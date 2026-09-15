param(
    [switch]$RestoreEnglish,
    [switch]$ValidateOnly,
    [string]$GamePath = '',
    [string]$ReportRoot = '',
    [switch]$NoPause
)

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$script:HadError = $false

$Version = 'V0.9.0'
$Tag = 'TEST_CANDIDATE_2'
$DefaultGame = ''

$OriginalManifestSHA = '786c3d475ed363c09691d2cb61fd6e5fa86b4bf6ccd08bdb98bd4fb348015c9f'
$OriginalPackageSHA  = '2751ace5dc9f5e1f0f8ae110b6e4e5118687353168d56f4bb36b0acc8f456d20'
$V08577ManifestSHA   = 'f93460e3089f8be10d8bff18ad0ea26ba07054efa04669efba95872a2db04337'
$V08577PackageSHA    = 'fd66181fee78180000acb9b3df0c0ee2c7cb07151822915e0f121c23984cd0db'
$V08578ManifestSHA   = '34f984e12897a97e28076d3509204ef6274810575f2f7df150060a72a5ab905b'
$V08578PackageSHA    = 'f3732594ad79fe27dad4cc0bbeb2405f590896a2b89ea141800ee5953a9e5f3b'
$V08579ManifestSHA   = '7f871e02c9b9276d798adaeb9791c00df012ab470a583b8726560312ee8d294c'
$V08579PackageSHA    = '5f2ace19c951b46265ce23320d3d5ecb3687bb9005de8784671ac105261a7e53'
$V08580ManifestSHA   = '87d5e435a01abf70221d93fbc5795a7269c4ffddf69d790d03d04f6248c455f0'
$V08580PackageSHA    = '6843717402c0b197e9c0dc6a51040308ddfe0193b0a7727369bffdc760a2fa97'
$V08583ManifestSHA   = 'cf58d7d611aae1fb754cb20f2d0ea45531ad7751fafd37ff464063a3e3eae800'
$V08583PackageSHA    = '966abfb605260d4b144022df7abae753ada50d4e5d0ccfb071e8b3d07a7a690a'

$TargetsCsv = Join-Path $PSScriptRoot 'PACKAGE_TARGETS.csv'
$QuoteTitleQaPlanV085849Csv = Join-Path $PSScriptRoot 'QUOTE_TITLE_QA_PACKAGE_DELTA_V0.8.58.4.9.csv'
$PunctGrammarQaPlanV0858410Csv = Join-Path $PSScriptRoot 'PUNCT_GRAMMAR_QA_PACKAGE_DELTA_V0.8.58.4.10.csv'
$FinalObjectiveQaPlanV0858411Csv = Join-Path $PSScriptRoot 'FINAL_OBJECTIVE_QA_PACKAGE_DELTA_V0.8.58.4.11.csv'
$PunctResidualQaPlanV0858412Csv = Join-Path $PSScriptRoot 'PUNCT_RESIDUAL_QA_PACKAGE_DELTA_V0.8.58.4.12.csv'
$NaturalResidualQaPlanV0858413Csv = Join-Path $PSScriptRoot 'NATURAL_RESIDUAL_QA_PACKAGE_DELTA_V0.8.58.4.13.csv'
$GlyphCompatPlanFromV085845Csv = Join-Path $PSScriptRoot 'GLYPH_COMPAT_PACKAGE_DELTA_V0.8.58.4.6.csv'
$GlyphCompatPlanFromV085842Csv = Join-Path $PSScriptRoot 'GLYPH_COMPAT_PACKAGE_DELTA_FROM_V0.8.58.4.2_V0.8.58.4.6.csv'
$UnicodeSafePlanV085847Csv = Join-Path $PSScriptRoot 'UNICODE_SAFE_PACKAGE_DELTA_V0.8.58.4.7.csv'
$QuestionQaPlanFromV085847Csv = Join-Path $PSScriptRoot 'QUESTION_QA_PACKAGE_DELTA_FROM_V0.8.58.4.7_V0.8.58.4.8.csv'
$QuestionQaPlanFromV085846Csv = Join-Path $PSScriptRoot 'QUESTION_QA_PACKAGE_DELTA_FROM_V0.8.58.4.6_V0.8.58.4.8.csv'
$TypographyPlanV08578Csv = Join-Path $PSScriptRoot 'TYPOGRAPHY_CORRECTIONS_V0.8.57.8.csv'
$EnglishTitlePlanV08579Csv = Join-Path $PSScriptRoot 'ENGLISH_TITLE_CORRECTIONS_V0.8.57.9.csv'
$CreditPlanV08580Csv = Join-Path $PSScriptRoot 'CREDIT_CORRECTIONS_V0.8.58.0.csv'
$CreditPlanV08584Csv = Join-Path $PSScriptRoot 'CREDIT_CORRECTIONS_V0.8.58.4.2.csv'
$CommunicationPlanV08583Csv = Join-Path $PSScriptRoot 'COMMUNICATION_PACKAGE_CORRECTIONS_V0.8.58.3.csv'
$GlobalDialoguePlanV08584Csv = Join-Path $PSScriptRoot 'GLOBAL_DIALOGUE_PACKAGE_UPGRADE_V0.8.58.4.2.csv'
$FinalTestFixV085841Csv = Join-Path $PSScriptRoot 'FINAL_TEST_CORRECTIONS_V0.8.58.4.2.csv'
$AieFixV085842Csv = Join-Path $PSScriptRoot 'AIE_CORRECTIONS_V0.8.58.4.2.csv'
$QaRecoveryV085845Csv = Join-Path $PSScriptRoot 'QA_RECOVERY_CORRECTIONS_V0.8.58.4.5.csv'
$ScriptFilePlanCsv = Join-Path $PSScriptRoot 'SCRIPT_DLL_FILE_PLAN_V0.8.58.4.12.csv'
$LegacyScriptFilePlanCsv = Join-Path $PSScriptRoot 'SCRIPT_DLL_FULL_V0.8.58.0_FILE_PLAN.csv'
$ScriptPatchDataPath = Join-Path $PSScriptRoot 'SCRIPT_DLL_PATCH_DATA_V0.8.58.4.12.bin'
$FontDir    = Join-Path $PSScriptRoot 'font_assets'

function Pause-End {
    if($NoPause) { return }
    Write-Host ''
    Read-Host 'Appuie sur Entree pour fermer' | Out-Null
}
function Get-Sha([string]$Path) {
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}
function Get-ShaBytes([byte[]]$Bytes) {
    $sha=[Security.Cryptography.SHA256]::Create()
    try {
        $hash=$sha.ComputeHash($Bytes)
        return (($hash | ForEach-Object {$_.ToString('x2')}) -join '')
    } finally {$sha.Dispose()}
}
function Get-U32([byte[]]$Bytes,[int]$Offset) {
    return [BitConverter]::ToUInt32($Bytes,$Offset)
}
function Set-U32([byte[]]$Bytes,[int]$Offset,[uint32]$Value) {
    $tmp=[BitConverter]::GetBytes($Value)
    [Buffer]::BlockCopy($tmp,0,$Bytes,$Offset,4)
}
function Slice-Bytes([byte[]]$Bytes,[int]$Start,[int]$Length) {
    $x=[byte[]]::new($Length)
    [Buffer]::BlockCopy($Bytes,$Start,$x,0,$Length)
    return $x
}
function Log([string]$Text) {
    $line='[{0}] {1}' -f (Get-Date -Format 'HH:mm:ss'),$Text
    Write-Host $line
    if($script:ReportDir -and (Test-Path -LiteralPath $script:ReportDir)) {
        Add-Content -LiteralPath (Join-Path $script:ReportDir '00_RESUME.txt') -Value $line -Encoding UTF8
    }
}
function Resolve-GamePath {
    if(-not [string]::IsNullOrWhiteSpace($GamePath)) {
        $p=$GamePath.Trim().Trim('"')
        if(-not(Test-Path -LiteralPath $p)) { throw 'Dossier de jeu introuvable.' }
        return $p
    }
    if(Test-Path -LiteralPath $DefaultGame) { return $DefaultGame }
    Write-Host ''
    Write-Host 'Le dossier habituel du jeu est introuvable :' -ForegroundColor Yellow
    Write-Host $DefaultGame
    Write-Host ''
    $p=Read-Host 'Colle ici le dossier racine de Lone Echo 2'
    $p=$p.Trim().Trim('"')
    if(-not(Test-Path -LiteralPath $p)) { throw 'Dossier de jeu introuvable.' }
    return $p
}
function Find-Zstd([string]$Game) {
    $cmd=Get-Command zstd.exe -ErrorAction SilentlyContinue
    if($cmd) { return $cmd.Source }

    $roots=@(
        $PSScriptRoot,
        $Game,
        [Environment]::GetFolderPath('Desktop'),
        (Join-Path $env:USERPROFILE 'Desktop'),
        (Join-Path $env:USERPROFILE 'OneDrive\Desktop'),
        (Join-Path $env:USERPROFILE 'Downloads')
    ) | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -Unique

    foreach($r in $roots) {
        $x=Get-ChildItem -LiteralPath $r -Filter 'zstd.exe' -File -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
        if($x) { return $x.FullName }
    }
    throw @'
zstd.exe est introuvable.
Le build utilise exactement la meme dependance que les previews validees precedentes.
Laisse simplement ton ancien zstd.exe quelque part dans le dossier du jeu, sur le Bureau ou dans Telechargements, puis relance ce CMD.
Aucun fichier du jeu n'a ete modifie.
'@
}
function Test-OriginalPair([string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $OriginalManifestSHA -and (Get-Sha $Package) -eq $OriginalPackageSHA)
    } catch { return $false }
}
function Test-V08577Pair([string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $V08577ManifestSHA -and (Get-Sha $Package) -eq $V08577PackageSHA)
    } catch { return $false }
}
function Test-V08578Pair([string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $V08578ManifestSHA -and (Get-Sha $Package) -eq $V08578PackageSHA)
    } catch { return $false }
}
function Test-V08579Pair([string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $V08579ManifestSHA -and (Get-Sha $Package) -eq $V08579PackageSHA)
    } catch { return $false }
}
function Test-V08580Pair([string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $V08580ManifestSHA -and (Get-Sha $Package) -eq $V08580PackageSHA)
    } catch { return $false }
}
function Test-V08583Pair([string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $V08583ManifestSHA -and (Get-Sha $Package) -eq $V08583PackageSHA)
    } catch { return $false }
}
function Get-V08584StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4_STATE.txt')
}
function Read-StateMap([string]$Path) {
    $m=@{}
    if(-not(Test-Path -LiteralPath $Path)) { return $m }
    foreach($line in Get-Content -LiteralPath $Path -Encoding UTF8) {
        $p=$line.IndexOf('=')
        if($p -gt 0) { $m[$line.Substring(0,$p)]=$line.Substring($p+1) }
    }
    return $m
}
function Test-V08584StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V08584StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256'])
    } catch { return $false }
}
function Get-V085841StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.1_STATE.txt')
}
function Test-V085841StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V085841StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.1') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256'])
    } catch { return $false }
}
function Get-V085842StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.2_STATE.txt')
}
function Test-V085842StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V085842StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.2') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256'])
    } catch { return $false }
}

function Get-V085845StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.5_STATE.txt')
}
function Test-V085845StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V085845StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.5') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256'])
    } catch { return $false }
}

function Get-V085846StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.6_STATE.txt')
}
function Test-V085846StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V085846StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.6') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256'])
    } catch { return $false }
}

function Get-V085847StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.7_STATE.txt')
}
function Test-V085847StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V085847StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.7') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256'])
    } catch { return $false }
}

function Get-V085848StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.8_STATE.txt')
}
function Test-V085848StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V085848StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.8') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256'])
    } catch { return $false }
}

function Get-V0858481StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.8.1_STATE.txt')
}
function Test-V0858481StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V0858481StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.8.1') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try {
        return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256'])
    } catch { return $false }
}

function Get-V085849StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.9_STATE.txt')
}
function Test-V085849StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V085849StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.9') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try { return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256']) } catch { return $false }
}

function Get-V0858410StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.10_STATE.txt')
}
function Test-V0858410StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V0858410StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.10') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try { return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256']) } catch { return $false }
}

function Get-V0858411StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.11_STATE.txt')
}
function Test-V0858411StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V0858411StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.11') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try { return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256']) } catch { return $false }
}

function Get-V0858412StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.12_STATE.txt')
}
function Test-V0858412StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V0858412StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.12') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try { return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256']) } catch { return $false }
}

function Get-V0858413StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.8.58.4.13_STATE.txt')
}
function Test-V0858413StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V0858413StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.8.58.4.13') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try { return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256']) } catch { return $false }
}



function Get-V090StatePath([string]$Game) {
    return (Join-Path $Game 'LE2_FR_V0.9.0_STATE.txt')
}
function Test-V090StatePair([string]$Game,[string]$Manifest,[string]$Package) {
    if(-not(Test-Path -LiteralPath $Manifest) -or -not(Test-Path -LiteralPath $Package)) { return $false }
    $state=Read-StateMap (Get-V090StatePath $Game)
    if(-not $state.ContainsKey('Version') -or $state['Version'] -ne 'V0.9.0') { return $false }
    if(-not $state.ContainsKey('ManifestSHA256') -or -not $state.ContainsKey('PackageSHA256')) { return $false }
    try { return ((Get-Sha $Manifest) -eq $state['ManifestSHA256'] -and (Get-Sha $Package) -eq $state['PackageSHA256']) } catch { return $false }
}
function Test-KnownRestorablePair([string]$Manifest,[string]$Package) {
    return ((Test-OriginalPair $Manifest $Package) -or
            (Test-V08577Pair $Manifest $Package) -or
            (Test-V08578Pair $Manifest $Package) -or
            (Test-V08579Pair $Manifest $Package) -or
            (Test-V08580Pair $Manifest $Package) -or
            (Test-V08583Pair $Manifest $Package))
}
function Resolve-PreviousPackageSource([string]$Game,[string]$Manifest,[string]$Package) {
    $backups=@(Get-ChildItem -LiteralPath $Game -Directory -Filter 'LE2_FR_Backup_BEFORE_V0.8.58.4*' -ErrorAction SilentlyContinue |
        Sort-Object LastWriteTime -Descending)
    foreach($backup in $backups) {
        $backupManifest=Join-Path $backup.FullName 'ff715342fa4b2d8f'
        $backupPackage=Join-Path $backup.FullName 'ff715342fa4b2d8f_0'
        if((Test-KnownRestorablePair $backupManifest $backupPackage) -or (Test-V08584StatePair $Game $backupManifest $backupPackage) -or (Test-V085841StatePair $Game $backupManifest $backupPackage) -or (Test-V085842StatePair $Game $backupManifest $backupPackage) -or (Test-V085845StatePair $Game $backupManifest $backupPackage) -or (Test-V085846StatePair $Game $backupManifest $backupPackage) -or (Test-V085847StatePair $Game $backupManifest $backupPackage) -or (Test-V085848StatePair $Game $backupManifest $backupPackage) -or (Test-V0858481StatePair $Game $backupManifest $backupPackage) -or (Test-V085849StatePair $Game $backupManifest $backupPackage) -or (Test-V0858410StatePair $Game $backupManifest $backupPackage) -or (Test-V0858411StatePair $Game $backupManifest $backupPackage) -or (Test-V0858412StatePair $Game $backupManifest $backupPackage) -or (Test-V0858413StatePair $Game $backupManifest $backupPackage)) {
            return [pscustomobject]@{
                Manifest=$backupManifest
                Package=$backupPackage
                Mode=('PREVIOUS_BACKUP:'+$backup.Name)
            }
        }
    }
    if(Test-KnownRestorablePair $Manifest $Package) {
        return [pscustomobject]@{Manifest=$Manifest;Package=$Package;Mode='LIVE_ALREADY_PREVIOUS'}
    }
    $original=Resolve-OriginalSource $Game $Manifest $Package
    return [pscustomobject]@{Manifest=$original.Manifest;Package=$original.Package;Mode=$original.Mode}
}
function Resolve-OriginalSource([string]$Game,[string]$Manifest,[string]$Package) {
    if(Test-OriginalPair $Manifest $Package) {
        return [pscustomobject]@{Manifest=$Manifest;Package=$Package;Mode='LIVE_ORIGINAL'}
    }

    $bases=@(
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.8.58.0',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.8.57.9',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.8.57.8',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.8.57.7',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.8.57.6',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.8.57.5',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.6.0.5',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.6.0.4',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.6.0.3',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.6.0.2',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.6.0.1',
        'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.6.0'
    )
    foreach($b in $bases) {
        $d=Join-Path $Game $b
        $m=Join-Path $d 'ff715342fa4b2d8f'
        $p=Join-Path $d 'ff715342fa4b2d8f_0'
        if(Test-OriginalPair $m $p) {
            return [pscustomobject]@{Manifest=$m;Package=$p;Mode=('CLEAN_BASE:'+ $b)}
        }
    }

    $mb=$Manifest+'.bak'
    $pb=$Package+'.bak'
    if(Test-OriginalPair $mb $pb) {
        return [pscustomobject]@{Manifest=$mb;Package=$pb;Mode='LEGACY_BAK'}
    }

    $liveM='MISSING'; $liveP='MISSING'
    if(Test-Path -LiteralPath $Manifest) {$liveM=Get-Sha $Manifest}
    if(Test-Path -LiteralPath $Package) {$liveP=Get-Sha $Package}
    throw ("Aucune paire anglaise originale valide n'a ete trouvee.`n"+
           "Manifest LIVE: "+$liveM+"`n"+
           "Package LIVE : "+$liveP+"`n"+
           "Manifest attendu: "+$OriginalManifestSHA+"`n"+
           "Package attendu : "+$OriginalPackageSHA)
}
function Resolve-InstallSource([string]$Game,[string]$Manifest,[string]$Package) {
    try {
        $original=Resolve-OriginalSource $Game $Manifest $Package
        $original | Add-Member -NotePropertyName SourceTextMode -NotePropertyValue 'ENGLISH'
        return $original
    } catch {
        if(Test-V090StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{Manifest=$Manifest;Package=$Package;Mode='LIVE_V0.9.0_CURRENT';SourceTextMode='V0.9.0_FR'}
        }
        if(Test-V0858413StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{Manifest=$Manifest;Package=$Package;Mode='LIVE_V0.8.58.4.13_CURRENT';SourceTextMode='V0.8.58.4.13_FR'}
        }
        if(Test-V0858412StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{Manifest=$Manifest;Package=$Package;Mode='LIVE_V0.8.58.4.12_CURRENT';SourceTextMode='V0.8.58.4.12_FR'}
        }
        if(Test-V0858411StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{Manifest=$Manifest;Package=$Package;Mode='LIVE_V0.8.58.4.11_CURRENT';SourceTextMode='V0.8.58.4.11_FR'}
        }
        if(Test-V0858410StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{Manifest=$Manifest;Package=$Package;Mode='LIVE_V0.8.58.4.10_CURRENT';SourceTextMode='V0.8.58.4.10_FR'}
        }
        if(Test-V085849StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{Manifest=$Manifest;Package=$Package;Mode='LIVE_V0.8.58.4.9_CURRENT';SourceTextMode='V0.8.58.4.9_FR'}
        }
        if(Test-V0858481StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.4.8.1_CURRENT'
                SourceTextMode='V0.8.58.4.8.1_FR'
            }
        }
        if(Test-V085848StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.4.8_CURRENT'
                SourceTextMode='V0.8.58.4.8_FR'
            }
        }
        if(Test-V085847StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.4.7_CURRENT'
                SourceTextMode='V0.8.58.4.7_FR'
            }
        }
        if(Test-V085846StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.4.6_CURRENT'
                SourceTextMode='V0.8.58.4.6_FR'
            }
        }
        if(Test-V085845StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.4.5_CURRENT'
                SourceTextMode='V0.8.58.4.5_FR'
            }
        }
        if(Test-V085842StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.4.2_CURRENT'
                SourceTextMode='V0.8.58.4.2_FR'
            }
        }
        if(Test-V085841StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.4.1_PREDECESSOR'
                SourceTextMode='V0.8.58.4.1_FR'
            }
        }
        if(Test-V08584StatePair $Game $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.4_PREDECESSOR'
                SourceTextMode='V0.8.58.4_FR'
            }
        }
        if(Test-V08583Pair $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.3_CURRENT'
                SourceTextMode='V0.8.58.3_FR'
            }
        }
        if(Test-V08580Pair $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.58.0_UPGRADE'
                SourceTextMode='V0.8.58.0_FR'
            }
        }
        if(Test-V08579Pair $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.57.9_UPGRADE'
                SourceTextMode='V0.8.57.9_FR'
            }
        }
        if(Test-V08578Pair $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.57.8_UPGRADE'
                SourceTextMode='V0.8.57.8_FR'
            }
        }
        if(Test-V08577Pair $Manifest $Package) {
            return [pscustomobject]@{
                Manifest=$Manifest
                Package=$Package
                Mode='LIVE_V0.8.57.7_UPGRADE'
                SourceTextMode='V0.8.57.7_FR'
            }
        }
        throw
    }
}
function Ensure-CleanBase([string]$Game,$Source) {
    $dir=Join-Path $Game 'LE2_FR_ORIGINAL_ENGLISH_BASE_V0.8.58.0'
    $m=Join-Path $dir 'ff715342fa4b2d8f'
    $p=Join-Path $dir 'ff715342fa4b2d8f_0'
    if(Test-OriginalPair $m $p) {
        return [pscustomobject]@{Dir=$dir;Manifest=$m;Package=$p}
    }
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    Copy-Item -LiteralPath $Source.Manifest -Destination $m -Force
    Copy-Item -LiteralPath $Source.Package -Destination $p -Force
    if(-not(Test-OriginalPair $m $p)) { throw 'Creation de la base anglaise persistante V0.8.58.0 echouee.' }
    @(
        'Version=V0.8.58.0',
        'SourceMode='+$Source.Mode,
        'ManifestSHA256='+$OriginalManifestSHA,
        'PackageSHA256='+$OriginalPackageSHA,
        'Created='+(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
    ) | Set-Content -LiteralPath (Join-Path $dir 'HASHES.txt') -Encoding UTF8
    return [pscustomobject]@{Dir=$dir;Manifest=$m;Package=$p}
}
function Expand-Manifest([string]$Source,[string]$Out,[string]$Zstd) {
    $b=[IO.File]::ReadAllBytes($Source)
    if($b.Length -lt 28 -or [Text.Encoding]::ASCII.GetString($b,0,4) -ne 'ZSTD') {
        throw 'Signature manifest inattendue.'
    }
    $frame=$Out+'.zst'
    $fs=[IO.File]::Open($frame,[IO.FileMode]::Create,[IO.FileAccess]::Write)
    try {$fs.Write($b,24,$b.Length-24)} finally {$fs.Dispose()}
    & $Zstd -q -d -f $frame -o $Out
    if($LASTEXITCODE -ne 0) { throw 'Decompression du manifest impossible.' }
    Remove-Item -LiteralPath $frame -Force -ErrorAction SilentlyContinue
}
function Parse-Manifest([string]$Decoded,[long]$PackageSize) {
    $b=[IO.File]::ReadAllBytes($Decoded)
    if($b.Length -lt 30184) { throw 'Manifest decode trop court.' }

    $secALen=[int](Get-U32 $b 24)
    $secACount1=[int](Get-U32 $b 56)
    $secACount2=[int](Get-U32 $b 64)
    $secBLen=[int](Get-U32 $b 88)
    $count=[int](Get-U32 $b 184)
    $rowStart=200+$secALen+$secBLen

    if($secALen -ne ($secACount1*32) -or $secACount1 -ne $secACount2) {
        throw 'Section A incoherente.'
    }
    if($secACount1 -ne 382 -or $count -ne 155) {
        throw ('Structure manifest inattendue : records='+$secACount1+' rows='+$count)
    }

    $rows=New-Object Collections.Generic.List[object]
    for($i=0;$i -lt $count;$i++) {
        $p=$rowStart+$i*16
        $pi=Get-U32 $b $p
        $co=Get-U32 $b ($p+4)
        $cs=Get-U32 $b ($p+8)
        $us=Get-U32 $b ($p+12)
        $valid=($pi -eq 0 -and $us -gt 0 -and ([long]$co+[long]$cs) -le $PackageSize)
        $rows.Add([pscustomobject]@{index=$i;offset=$co;csize=$cs;usize=$us;valid=$valid})
    }
    return [pscustomobject]@{
        bytes=$b; secAStart=200; secACount=$secACount1; rowStart=$rowStart; rows=$rows
    }
}
function Make-Manifest([string]$BaseManifest,[byte[]]$Decoded,[string]$Frame,[string]$Out) {
    $base=[IO.File]::ReadAllBytes($BaseManifest)
    $fr=[IO.File]::ReadAllBytes($Frame)
    $head=[byte[]]::new(24)
    [Buffer]::BlockCopy($base,0,$head,0,24)
    Set-U32 $head 8 ([uint32]$Decoded.Length)
    Set-U32 $head 16 ([uint32]$fr.Length)
    $fs=[IO.File]::Open($Out,[IO.FileMode]::Create,[IO.FileAccess]::Write)
    try {
        $fs.Write($head,0,24)
        $fs.Write($fr,0,$fr.Length)
    } finally {$fs.Dispose()}
}
function Get-ChunkAssets([byte[]]$ManifestBytes,$Manifest,[int]$Chunk) {
    $items=@()
    for($i=0;$i -lt [int]$Manifest.secACount;$i++) {
        $p=[int]$Manifest.secAStart+$i*32
        if([int](Get-U32 $ManifestBytes ($p+16)) -ne $Chunk) { continue }
        $items += [pscustomobject]@{
            record=$i
            pos=$p
            offset=[long](Get-U32 $ManifestBytes ($p+20))
            size=[long](Get-U32 $ManifestBytes ($p+24))
            flags=Get-U32 $ManifestBytes ($p+28)
        }
    }
    return @($items)
}
function Validate-ChunkPartition([byte[]]$ManifestBytes,$Manifest,[int]$Chunk,[long]$ExpectedLength) {
    $a=@(Get-ChunkAssets $ManifestBytes $Manifest $Chunk | Sort-Object offset)
    if($a.Count -lt 1) { throw ('Aucun asset Section A pour chunk '+$Chunk) }
    if([long]$a[0].offset -ne 0) { throw ('Premier asset chunk '+$Chunk+' != 0') }
    for($i=0;$i -lt $a.Count;$i++) {
        if([long]$a[$i].flags -ne 16) { throw ('Flags inattendus chunk '+$Chunk+' record '+$a[$i].record) }
        if($i -lt $a.Count-1) {
            if(([long]$a[$i].offset+[long]$a[$i].size) -ne [long]$a[$i+1].offset) {
                throw ('Rupture Section A chunk '+$Chunk+' entre '+$a[$i].record+' et '+$a[$i+1].record)
            }
        }
    }
    $last=$a[$a.Count-1]
    if(([long]$last.offset+[long]$last.size) -ne $ExpectedLength) {
        throw ('Couverture Section A chunk '+$Chunk+' incorrecte.')
    }
    return $a
}
function Extract-Chunk([string]$Package,$Row,[string]$Zstd,[string]$Work,[int]$Chunk) {
    $z=Join-Path $Work ('chunk_'+$Chunk+'.zst')
    $d=Join-Path $Work ('chunk_'+$Chunk+'.dec')
    $src=[IO.File]::Open($Package,[IO.FileMode]::Open,[IO.FileAccess]::Read,[IO.FileShare]::Read)
    try {
        [void]$src.Seek([long]$Row.offset,[IO.SeekOrigin]::Begin)
        $buf=[byte[]]::new([int]$Row.csize)
        $done=0
        while($done -lt $buf.Length) {
            $n=$src.Read($buf,$done,$buf.Length-$done)
            if($n -le 0) { throw ('Lecture chunk '+$Chunk+' incomplete.') }
            $done+=$n
        }
        [IO.File]::WriteAllBytes($z,$buf)
    } finally {$src.Dispose()}
    & $Zstd -q -d -f $z -o $d
    if($LASTEXITCODE -ne 0) { throw ('Decompression chunk '+$Chunk+' impossible.') }
    return $d
}
function Read-StringTable([byte[]]$Bytes) {
    if($Bytes.Length -lt 16) { throw 'Asset trop court pour etre une table de chaines.' }
    $n=[int](Get-U32 $Bytes 0)
    if($n -le 0 -or $n -gt 5000) { throw 'Nombre de chaines invalide.' }
    $count2Pos=4+8*$n
    if($count2Pos+4 -gt $Bytes.Length) { throw 'Table tronquee.' }
    if([int](Get-U32 $Bytes $count2Pos) -ne $n) { throw 'Double compteur incoherent.' }
    $offsetPos=$count2Pos+4
    $base=$offsetPos+4*($n+1)
    if($base -gt $Bytes.Length) { throw 'Base pool hors limites.' }

    $offs=[uint32[]]::new($n+1)
    for($i=0;$i -le $n;$i++) {
        $offs[$i]=Get-U32 $Bytes ($offsetPos+4*$i)
        if($i -eq 0 -and $offs[$i] -ne 0) { throw 'Premier offset non nul.' }
        if($i -gt 0 -and $offs[$i] -le $offs[$i-1]) { throw 'Offsets non croissants.' }
    }
    $end=[long]$base+[long]$offs[$n]
    if($end -ne $Bytes.Length) { throw 'Asset cible != table de chaines complete.' }
    for($i=0;$i -lt $n;$i++) {
        $last=$base+[int]$offs[$i+1]-1
        if($Bytes[$last] -ne 0) { throw 'Terminaison NUL absente.' }
    }
    return [pscustomobject]@{count=$n;offsetPos=$offsetPos;base=$base;offsets=$offs}
}
function Get-SlotText([byte[]]$Bytes,$Table,[int]$Slot) {
    $a=$Table.base+[int]$Table.offsets[$Slot]
    $e=$Table.base+[int]$Table.offsets[$Slot+1]-1
    $len=$e-$a
    while($len -gt 0 -and $Bytes[$a+$len-1] -eq 0) {$len--}
    if($len -le 0) { return '' }
    return [Text.Encoding]::UTF8.GetString($Bytes,$a,$len)
}
function Get-IdHex([byte[]]$Bytes,[int]$Slot) {
    $p=4+8*$Slot
    $x=[byte[]]::new(8)
    [Buffer]::BlockCopy($Bytes,$p,$x,0,8)
    return (($x | ForEach-Object {$_.ToString('x2')}) -join '')
}
function Rebuild-StringAsset([byte[]]$Asset,[object[]]$Targets,[int]$Record) {
    $t=Read-StringTable $Asset
    $slotMap=@{}
    foreach($r in $Targets) {
        $slot=[int]$r.slot
        if($slot -lt 0 -or $slot -ge $t.count) {
            throw ('Slot hors limites record '+$Record+' slot '+$slot+'/'+$t.count)
        }
        $current=Get-SlotText $Asset $t $slot
        if($current -ne [string]$r.sourceText) {
            throw ('Texte source inattendu record '+$Record+' slot '+$slot+
                   '`nTrouve : "'+$current+'"`nAttendu: "'+[string]$r.sourceText+'"')
        }
        $id=Get-IdHex $Asset $slot
        if($id -ne ([string]$r.idHex).ToLowerInvariant()) {
            throw ('ID 8 octets inattendu record '+$Record+' slot '+$slot+
                   ' trouve='+$id+' attendu='+[string]$r.idHex)
        }
        $slotMap[$slot]=[string]$r.textFR
        $r.found=$true
    }

    $ms=[IO.MemoryStream]::new()
    try {
        $ms.Write($Asset,0,$t.base)
        $newOffsets=[uint32[]]::new($t.count+1)
        $newOffsets[0]=0

        for($i=0;$i -lt $t.count;$i++) {
            if($slotMap.ContainsKey($i)) {
                $bb=[Text.Encoding]::UTF8.GetBytes([string]$slotMap[$i])
                $ms.Write($bb,0,$bb.Length)
                $ms.WriteByte(0)
            } else {
                $a=$t.base+[int]$t.offsets[$i]
                $len=[int]($t.offsets[$i+1]-$t.offsets[$i])
                $ms.Write($Asset,$a,$len)
            }
            $newOffsets[$i+1]=[uint32]($ms.Position-$t.base)
        }
        $result=$ms.ToArray()
    } finally {$ms.Dispose()}

    for($i=0;$i -le $t.count;$i++) {
        Set-U32 $result ($t.offsetPos+4*$i) $newOffsets[$i]
    }

    $verify=Read-StringTable $result
    foreach($r in $Targets) {
        if((Get-SlotText $result $verify ([int]$r.slot)) -ne [string]$r.textFR) {
            throw ('Validation FR echouee record '+$Record+' slot '+$r.slot)
        }
    }
    return $result
}
function Backup-Live([string]$Game,[string]$Manifest,[string]$Package) {
    $stamp=Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
    $dir=Join-Path $Game ('LE2_FR_Backup_BEFORE_V0.9.0_'+$stamp)
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    if(Test-Path -LiteralPath $Manifest) { Copy-Item -LiteralPath $Manifest -Destination (Join-Path $dir 'ff715342fa4b2d8f') -Force }
    if(Test-Path -LiteralPath $Package)  { Copy-Item -LiteralPath $Package  -Destination (Join-Path $dir 'ff715342fa4b2d8f_0') -Force }
    return $dir
}

function Import-ScriptFilePlan {
    if(-not(Test-Path -LiteralPath $ScriptFilePlanCsv)) { throw 'Plan des DLL scripts introuvable.' }
    if(-not(Test-Path -LiteralPath $ScriptPatchDataPath)) { throw 'Donnees de patch des DLL scripts introuvables.' }
    $plan=@(Import-Csv -LiteralPath $ScriptFilePlanCsv -Delimiter ';' -Encoding UTF8)
    if($plan.Count -ne 233) { throw ('Plan DLL ciblees inattendu: '+$plan.Count+'/233') }
    $seen=@{}
    $translated=0
    $identical=0
    foreach($r in $plan) {
        $rel=[string]$r.sourcePath
        if([string]::IsNullOrWhiteSpace($rel) -or [IO.Path]::IsPathRooted($rel) -or $rel -match '(^|[\\/])\.\.([\\/]|$)') {
            throw ('Chemin DLL scripts interdit: '+$rel)
        }
        $key=$rel.ToLowerInvariant()
        if($seen.ContainsKey($key)) { throw ('DLL dupliquee dans le plan: '+$rel) }
        $seen[$key]=$true
        $translated += [int]$r.translatedRows
        $identical += [int]$r.identicalRows
    }
    if(($translated+$identical) -ne 618 -or $translated -ne 616 -or $identical -ne 2) {
        throw ('Repartition SCRIPT_DLL inattendue: FR='+$translated+' identiques='+$identical)
    }
    return $plan
}

function Import-LegacyScriptFilePlan {
    if(-not(Test-Path -LiteralPath $LegacyScriptFilePlanCsv)) { throw 'Plan complet V0.8.58.0 des DLL scripts introuvable.' }
    $plan=@(Import-Csv -LiteralPath $LegacyScriptFilePlanCsv -Delimiter ';' -Encoding UTF8)
    if($plan.Count -ne 4249) { throw ('Plan complet DLL scripts inattendu: '+$plan.Count+'/4249') }
    $seen=@{}
    $translated=0
    $identical=0
    $changed=0
    foreach($r in $plan) {
        $rel=[string]$r.sourcePath
        if([string]::IsNullOrWhiteSpace($rel) -or [IO.Path]::IsPathRooted($rel) -or $rel -match '(^|[\/])\.\.([\/]|$)') {
            throw ('Chemin DLL scripts interdit: '+$rel)
        }
        $key=$rel.ToLowerInvariant()
        if($seen.ContainsKey($key)) { throw ('DLL dupliquee dans le plan complet: '+$rel) }
        $seen[$key]=$true
        $translated += [int]$r.translatedRows
        $identical += [int]$r.identicalRows
        if([int]$r.patchOperationCount -gt 0) { $changed++ }
    }
    if(($translated+$identical) -ne 11252 -or $translated -ne 11174 -or $identical -ne 78 -or $changed -ne 4244) {
        throw ('Plan complet SCRIPT_DLL inattendu: FR='+$translated+' identiques='+$identical+' DLL='+$changed)
    }
    return $plan
}

function Test-ScriptTree([string]$Root,[object[]]$Plan,[switch]$FrenchResult) {
    if(-not(Test-Path -LiteralPath $Root)) {
        return [pscustomobject]@{Valid=$false;Checked=0;Mismatches=$Plan.Count;First='DOSSIER_ABSENT'}
    }
    $checked=0
    $mismatches=0
    $first=''
    foreach($r in $Plan) {
        $path=Join-Path $Root ([string]$r.sourcePath)
        $expectedSize=if($FrenchResult){[long]$r.resultSize}else{[long]$r.originalSize}
        $expectedSha=if($FrenchResult){[string]$r.resultSHA256}else{[string]$r.originalSHA256}
        $ok=$false
        if(Test-Path -LiteralPath $path) {
            $item=Get-Item -LiteralPath $path
            if($item.Length -eq $expectedSize) {
                $ok=((Get-Sha $path) -eq $expectedSha)
            }
        }
        $checked++
        if(-not $ok) {
            $mismatches++
            if(-not $first) { $first=[string]$r.sourcePath }
        }
    }
    return [pscustomobject]@{Valid=($mismatches -eq 0);Checked=$checked;Mismatches=$mismatches;First=$first}
}

function Resolve-OriginalScripts([string]$Game,[string]$ScriptsLive,[object[]]$Plan) {
    $base=Join-Path $Game 'LE2_FR_ORIGINAL_SCRIPTS_BASE_V0.8.58.0'
    $baseTest=Test-ScriptTree $base $Plan
    if($baseTest.Valid) {
        return [pscustomobject]@{Path=$base;Mode='CLEAN_SCRIPTS_BASE_V0.8.58.0';Base=$base}
    }
    $liveTest=Test-ScriptTree $ScriptsLive $Plan
    if($liveTest.Valid) {
        return [pscustomobject]@{Path=$ScriptsLive;Mode='LIVE_ORIGINAL_SCRIPTS';Base=$base}
    }
    throw ('Aucune source scripts anglaise valide. LIVE ecarts='+$liveTest.Mismatches+
           ' premier='+$liveTest.First+'; BASE ecarts='+$baseTest.Mismatches+' premier='+$baseTest.First)
}

function Ensure-CleanScriptsBase($Resolved,[object[]]$Plan) {
    $base=[string]$Resolved.Base
    $test=Test-ScriptTree $base $Plan
    if($test.Valid) { return $base }
    if(Test-Path -LiteralPath $base) {
        throw ('La base scripts existe mais elle est invalide: '+$base+'; premier ecart='+$test.First)
    }
    Log '      Creation de la base persistante des scripts anglais...'
    New-Item -ItemType Directory -Path $base -Force | Out-Null
    $copied=0
    foreach($r in $Plan) {
        $rel=[string]$r.sourcePath
        $src=Join-Path ([string]$Resolved.Path) $rel
        $dst=Join-Path $base $rel
        $parent=Split-Path -Parent $dst
        if(-not(Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
        Copy-Item -LiteralPath $src -Destination $dst -Force
        $copied++
        if(($copied % 500) -eq 0) { Log ('      Base scripts: '+$copied+'/'+$Plan.Count) }
    }
    $verify=Test-ScriptTree $base $Plan
    if(-not $verify.Valid) { throw ('Validation de la base scripts echouee: '+$verify.First) }
    @(
        'Version=V0.8.58.0',
        ('SourceMode='+$Resolved.Mode),
        'Files=4249/4249',
        ('PlanSHA256='+(Get-Sha $LegacyScriptFilePlanCsv)),
        ('Created='+(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
    ) | Set-Content -LiteralPath (Join-Path $base 'HASHES.txt') -Encoding UTF8
    return $base
}

function Build-ScriptDlls([string]$SourceRoot,[object[]]$Plan,[string]$OutputRoot) {
    $patch=[IO.File]::ReadAllBytes($ScriptPatchDataPath)
    if((Get-ShaBytes $patch) -ne 'c0297d7b7f0b1a735367fe153d5184533686329f4cbeafc7ba18abeb7ab5a769') {
        throw 'Empreinte des donnees de patch SCRIPT_DLL incorrecte.'
    }
    New-Item -ItemType Directory -Path $OutputRoot -Force | Out-Null
    $changed=[string[]]::new(233)
    $changedIndex=0
    $resultHashes=@{}
    $audit=New-Object Collections.Generic.List[string]
    [void]$audit.Add('sourcePath;originalSize;resultSize;translatedRows;identicalRows;xrefCount;patchOperations;originalSHA256;resultSHA256;status')
    $fileIndex=0; $translated=0; $identical=0; $xrefCount=0
    foreach($r in $Plan) {
        $fileIndex++
        $rel=[string]$r.sourcePath
        $src=Join-Path $SourceRoot $rel
        if(-not(Test-Path -LiteralPath $src)) { throw ('DLL script source absente: '+$rel) }
        $original=[IO.File]::ReadAllBytes($src)
        if($original.Length -ne [int]$r.originalSize -or (Get-ShaBytes $original) -ne [string]$r.originalSHA256) {
            throw ('DLL script source invalide: '+$rel)
        }
        $start=[int]$r.patchDataOffset; $limit=$start+[int]$r.patchDataLength
        if($start -lt 0 -or $limit -gt $patch.Length -or $limit -lt $start+4) { throw ('Bloc patch hors limites: '+$rel) }
        $cursor=$start; $operationCount=[int](Get-U32 $patch $cursor); $cursor+=4
        if($operationCount -ne [int]$r.patchOperationCount) { throw ('Nombre d operations incoherent: '+$rel) }
        $result=[byte[]]::new([int]$r.resultSize)
        if($original.Length -gt $result.Length) { throw ('Taille finale scripts trop petite: '+$rel) }
        [Buffer]::BlockCopy($original,0,$result,0,$original.Length)
        $previousEnd=-1
        for($op=0;$op -lt $operationCount;$op++) {
            if($cursor+8 -gt $limit) { throw ('Entete operation tronquee: '+$rel) }
            $offset=[int](Get-U32 $patch $cursor); $length=[int](Get-U32 $patch ($cursor+4)); $cursor+=8
            if($length -le 0 -or $offset -lt $previousEnd -or $offset+$length -gt $result.Length -or $cursor+$length -gt $limit) {
                throw ('Operation patch invalide: '+$rel+' operation '+$op)
            }
            [Buffer]::BlockCopy($patch,$cursor,$result,$offset,$length)
            $cursor+=$length; $previousEnd=$offset+$length
        }
        if($cursor -ne $limit) { throw ('Bloc patch non consomme exactement: '+$rel) }
        $resultSha=Get-ShaBytes $result
        $resultHashes[$rel.ToLowerInvariant()]=$resultSha
        if($operationCount -gt 0) {
            $dst=Join-Path $OutputRoot $rel
            $parent=Split-Path -Parent $dst
            if(-not(Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
            [IO.File]::WriteAllBytes($dst,$result)
            if((Get-Sha $dst) -ne $resultSha) { throw ('Verification DLL construite echouee: '+$rel) }
            if($changedIndex -ge $changed.Length) { throw 'Trop de DLL scripts modifiees.' }
            $changed[$changedIndex]=$rel; $changedIndex++
        }
        $translated += [int]$r.translatedRows; $identical += [int]$r.identicalRows; $xrefCount += [int]$r.xrefCount
        [void]$audit.Add(('{0};{1};{2};{3};{4};{5};{6};{7};{8};VERIFIED_RUNTIME_SHA' -f
            $rel,$r.originalSize,$r.resultSize,$r.translatedRows,$r.identicalRows,$r.xrefCount,$operationCount,$r.originalSHA256,$resultSha))
    }
    if($translated -ne 616 -or $identical -ne 2 -or $xrefCount -ne 620 -or $changedIndex -ne 233) {
        throw ('Bilan SCRIPT_DLL inattendu: FR='+$translated+' identiques='+$identical+' refs='+$xrefCount+' DLL='+$changedIndex)
    }
    [IO.File]::WriteAllLines((Join-Path $script:ReportDir 'SCRIPT_DLL_BUILD_AUDIT_V0.8.58.4.8.csv'),$audit,(New-Object Text.UTF8Encoding($true)))
    return [pscustomobject]@{OutputRoot=$OutputRoot;ChangedFiles=$changed;CheckedFiles=$fileIndex;TranslatedRows=$translated;IdenticalRows=$identical;XrefCount=$xrefCount;ResultHashes=$resultHashes}
}

function Install-ScriptDlls([string]$BuildRoot,[string]$LiveRoot,[object[]]$Plan,[string[]]$ChangedFiles,$ResultHashes) {
    $done=0
    foreach($rel in $ChangedFiles) {
        $src=Join-Path $BuildRoot $rel; $dst=Join-Path $LiveRoot $rel
        $parent=Split-Path -Parent $dst
        if(-not(Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
        Copy-Item -LiteralPath $src -Destination $dst -Force
        $key=$rel.ToLowerInvariant()
        if(-not $ResultHashes.ContainsKey($key) -or (Get-Sha $dst) -ne [string]$ResultHashes[$key]) { throw ('Verification DLL LIVE echouee: '+$rel) }
        $done++
    }
    if($done -ne 233) { throw ('DLL ciblees installees: '+$done+'/233') }
}

function Restore-ScriptDlls([string]$BaseRoot,[string]$LiveRoot,[object[]]$Plan) {
    $baseTest=Test-ScriptTree $BaseRoot $Plan
    if(-not $baseTest.Valid) { throw ('Base scripts anglaise invalide: '+$baseTest.First) }
    $done=0
    foreach($r in $Plan) {
        if([int]$r.patchOperationCount -le 0) { continue }
        $rel=[string]$r.sourcePath
        $src=Join-Path $BaseRoot $rel
        $dst=Join-Path $LiveRoot $rel
        Copy-Item -LiteralPath $src -Destination $dst -Force
        $done++
    }
    $verify=Test-ScriptTree $LiveRoot $Plan
    if(-not $verify.Valid) { throw ('Restauration scripts anglaise echouee: '+$verify.First) }
    if($done -ne 4244) { throw ('DLL scripts restaurees: '+$done+'/4244') }
}

function Test-FinalScriptTree([string]$Root,[object[]]$LegacyPlan,[object[]]$SelectedPlan,$ResultHashes) {
    $selected=@{}
    foreach($r in $SelectedPlan) { $selected[([string]$r.sourcePath).ToLowerInvariant()]=$r }
    $checked=0; $mismatches=0; $first=''
    foreach($legacy in $LegacyPlan) {
        $rel=[string]$legacy.sourcePath; $key=$rel.ToLowerInvariant(); $path=Join-Path $Root $rel
        if($selected.ContainsKey($key)) { $expectedSize=[long]$selected[$key].resultSize; $expectedSha=[string]$ResultHashes[$key] }
        else { $expectedSize=[long]$legacy.originalSize; $expectedSha=[string]$legacy.originalSHA256 }
        $ok=$false
        if(Test-Path -LiteralPath $path) { $item=Get-Item -LiteralPath $path; if($item.Length -eq $expectedSize) { $ok=((Get-Sha $path) -eq $expectedSha) } }
        $checked++
        if(-not $ok) { $mismatches++; if(-not $first) { $first=$rel } }
    }
    return [pscustomobject]@{Valid=($mismatches -eq 0);Checked=$checked;Mismatches=$mismatches;First=$first}
}

$Game=Resolve-GamePath
$Manifest=Join-Path $Game '_data\5932408047\rad16\win10\manifests\ff715342fa4b2d8f'
$Package=Join-Path $Game '_data\5932408047\rad16\win10\packages\ff715342fa4b2d8f_0'
$ScriptsLive=Join-Path $Game 'bin\win10\scripts'

$TimeStamp=Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
if([string]::IsNullOrWhiteSpace($ReportRoot)) { $ReportRoot=$PSScriptRoot }
New-Item -ItemType Directory -Path $ReportRoot -Force | Out-Null
$script:ReportDir=Join-Path $ReportRoot ("Rapport_LoneEcho2_FR_{0}_{1}_{2}" -f $Version,$Tag,$TimeStamp)
$ReportZip=$script:ReportDir+'.zip'
$Work=Join-Path $env:TEMP ('LE2_V085842_'+[Guid]::NewGuid().ToString('N'))
$InstallStarted=$false
$CleanScriptsBase=''

New-Item -ItemType Directory -Path $script:ReportDir -Force | Out-Null
New-Item -ItemType Directory -Path $Work -Force | Out-Null

try {
    Log '============================================================'
    Log 'LONE ECHO II - TRADUCTION FRANCAISE V0.9.0 TEST CANDIDATE 2'
    Log '============================================================'

    if($RestoreEnglish) {
        $legacyScriptPlan=@(Import-LegacyScriptFilePlan)
        $scriptResolved=Resolve-OriginalScripts $Game $ScriptsLive $legacyScriptPlan
        $original=Resolve-OriginalSource $Game $Manifest $Package
        $cleanOriginal=Ensure-CleanBase $Game $original
        Log ('Restauration ANGLAISE PACKAGE + scripts depuis '+$original.Mode+'...')
        Copy-Item -LiteralPath $cleanOriginal.Package -Destination $Package -Force
        Copy-Item -LiteralPath $cleanOriginal.Manifest -Destination $Manifest -Force
        if(-not(Test-OriginalPair $Manifest $Package)) { throw 'Controle de restauration anglaise PACKAGE echoue.' }
        if($scriptResolved.Mode -ne 'LIVE_ORIGINAL_SCRIPTS') {
            Restore-ScriptDlls $scriptResolved.Path $ScriptsLive $legacyScriptPlan
        }
        $scriptsCheck=Test-ScriptTree $ScriptsLive $legacyScriptPlan
        if(-not $scriptsCheck.Valid) { throw ('Controle de restauration anglaise SCRIPT_DLL echoue: '+$scriptsCheck.First) }
        Log 'JEU ANGLAIS ORIGINAL RESTAURE.'
        Log ('Manifest SHA256: '+(Get-Sha $Manifest))
        Log ('Package SHA256 : '+(Get-Sha $Package))
        return
    }

    $Source=Resolve-InstallSource $Game $Manifest $Package
    if($Source.SourceTextMode -eq 'ENGLISH') {
        $Clean=Ensure-CleanBase $Game $Source
    } else {
        $Clean=$Source
    }

    $Zstd=Find-Zstd $Game
    Log ('zstd: '+$Zstd)
    Log ('Source de reconstruction: '+$Source.Mode)
    $scriptPlan=@(Import-ScriptFilePlan)
    $legacyScriptPlan=@(Import-LegacyScriptFilePlan)
    Log 'Validation de la source anglaise des 4249 DLL scripts...'
    $scriptSource=Resolve-OriginalScripts $Game $ScriptsLive $legacyScriptPlan
    Log ('Source SCRIPT_DLL: '+$scriptSource.Mode)
    $backup='NOT_CREATED'

    $targets=@(Import-Csv -LiteralPath $TargetsCsv -Delimiter ';' -Encoding UTF8)
    if($targets.Count -ne 32307) { throw ('Nombre de cibles PACKAGE inattendu: '+$targets.Count+'/32307') }

    # PowerShell Import-Csv peut normaliser un champ contenant uniquement un espace en chaine vide.
    # Cette cible technique est intentionnellement un espace simple dans le jeu : on la restaure
    # explicitement par son identifiant stable afin que les futures regenerations CSV restent robustes.
    $technicalSpaceTargets=@($targets | Where-Object {
        [string]$_.chunk -eq '5' -and [string]$_.assetRecord -eq '50' -and
        [string]$_.slot -eq '0' -and ([string]$_.idHex).ToLowerInvariant() -eq '9d381186cb3f2289'
    })
    if($technicalSpaceTargets.Count -ne 1) { throw ('Cible espace technique inattendue: '+$technicalSpaceTargets.Count+'/1') }
    $technicalSpaceTargets[0].textEN=' '
    $technicalSpaceTargets[0].textFR=' '

    $upgradeOldByKey=@{}
    $upgradePlans=@()
    if($Source.SourceTextMode -eq 'V0.8.57.7_FR') {
        $plan=@(Import-Csv -LiteralPath $TypographyPlanV08578Csv -Delimiter ';' -Encoding UTF8)
        if($plan.Count -ne 492) { throw ('Plan typographie inattendu: '+$plan.Count+'/492') }
        $upgradePlans += $plan
    }
    if($Source.SourceTextMode -eq 'V0.8.57.8_FR') {
        $plan=@(Import-Csv -LiteralPath $EnglishTitlePlanV08579Csv -Delimiter ';' -Encoding UTF8)
        if($plan.Count -ne 14) { throw ('Plan de titres anglais inattendu: '+$plan.Count+'/14') }
        $upgradePlans += $plan
    }
    if($Source.SourceTextMode -eq 'V0.8.57.7_FR' -or $Source.SourceTextMode -eq 'V0.8.57.8_FR' -or $Source.SourceTextMode -eq 'V0.8.57.9_FR') {
        $plan=@(Import-Csv -LiteralPath $CreditPlanV08580Csv -Delimiter ';' -Encoding UTF8)
        if($plan.Count -ne 3) { throw ('Plan de credit inattendu: '+$plan.Count+'/3') }
        $upgradePlans += $plan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.0_FR') {
        $plan=@(Import-Csv -LiteralPath $CommunicationPlanV08583Csv -Delimiter ';' -Encoding UTF8)
        if($plan.Count -ne 70) { throw ('Plan COMMUNICATION inattendu: '+$plan.Count+'/70') }
        $upgradePlans += $plan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.3_FR') {
        $plan=@(Import-Csv -LiteralPath $GlobalDialoguePlanV08584Csv -Delimiter ';' -Encoding UTF8)
        if($plan.Count -ne 10073) { throw ('Plan GLOBAL DIALOGUE inattendu: '+$plan.Count+'/10073') }
        $upgradePlans += $plan
        $creditPlan=@(Import-Csv -LiteralPath $CreditPlanV08584Csv -Delimiter ';' -Encoding UTF8)
        if($creditPlan.Count -ne 3) { throw ('Plan credit options V0.8.58.4 inattendu: '+$creditPlan.Count+'/3') }
        $upgradePlans += $creditPlan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4_FR') {
        $plan=@(Import-Csv -LiteralPath $FinalTestFixV085841Csv -Delimiter ';' -Encoding UTF8)
        if($plan.Count -ne 38) { throw ('Plan FINAL TEST FIX inattendu: '+$plan.Count+'/38') }
        $upgradePlans += $plan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.1_FR') {
        $plan=@(Import-Csv -LiteralPath $AieFixV085842Csv -Delimiter ';' -Encoding UTF8)
        if($plan.Count -ne 3) { throw ('Plan AIE FIX inattendu: '+$plan.Count+'/3') }
        $upgradePlans += $plan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.2_FR') {
        $plan=@(Import-Csv -LiteralPath $QaRecoveryV085845Csv -Delimiter ';' -Encoding UTF8)
        if($plan.Count -ne 1168) { throw ('Plan QA RECOVERY inattendu: '+$plan.Count+'/1168') }
        $upgradePlans += $plan
        $glyphPlan=@(Import-Csv -LiteralPath $GlyphCompatPlanFromV085842Csv -Delimiter ';' -Encoding UTF8)
        if($glyphPlan.Count -ne 325) { throw ('Plan GLYPH COMPAT V0.8.58.4.2 inattendu: '+$glyphPlan.Count+'/325') }
        $upgradePlans += $glyphPlan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.5_FR') {
        $glyphPlan=@(Import-Csv -LiteralPath $GlyphCompatPlanFromV085845Csv -Delimiter ';' -Encoding UTF8)
        if($glyphPlan.Count -ne 334) { throw ('Plan GLYPH COMPAT V0.8.58.4.5 inattendu: '+$glyphPlan.Count+'/334') }
        $upgradePlans += $glyphPlan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.6_FR') {
        $qPlan=@(Import-Csv -LiteralPath $QuestionQaPlanFromV085846Csv -Delimiter ';' -Encoding UTF8)
        if($qPlan.Count -ne 215) { throw ('Plan QUESTION QA V0.8.58.4.6 inattendu: '+$qPlan.Count+'/215') }
        $upgradePlans += $qPlan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.7_FR') {
        $qPlan=@(Import-Csv -LiteralPath $QuestionQaPlanFromV085847Csv -Delimiter ';' -Encoding UTF8)
        if($qPlan.Count -ne 107) { throw ('Plan QUESTION QA V0.8.58.4.7 inattendu: '+$qPlan.Count+'/107') }
        $upgradePlans += $qPlan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.9_FR') {
        $pgPlan=@(Import-Csv -LiteralPath $PunctGrammarQaPlanV0858410Csv -Delimiter ';' -Encoding UTF8)
        if($pgPlan.Count -ne 63) { throw ('Plan PUNCT GRAMMAR QA inattendu: '+$pgPlan.Count+'/63') }
        $upgradePlans += $pgPlan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.10_FR') {
        $foPlan=@(Import-Csv -LiteralPath $FinalObjectiveQaPlanV0858411Csv -Delimiter ';' -Encoding UTF8)
        if($foPlan.Count -ne 20) { throw ('Plan FINAL OBJECTIVE QA inattendu: '+$foPlan.Count+'/20') }
        $upgradePlans += $foPlan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.11_FR') {
        $prPlan=@(Import-Csv -LiteralPath $PunctResidualQaPlanV0858412Csv -Delimiter ';' -Encoding UTF8)
        if($prPlan.Count -ne 17) { throw ('Plan PUNCT RESIDUAL QA inattendu: '+$prPlan.Count+'/17') }
        $upgradePlans += $prPlan
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.12_FR') {
        $nrPlan=@(Import-Csv -LiteralPath $NaturalResidualQaPlanV0858413Csv -Delimiter ';' -Encoding UTF8)
        if($nrPlan.Count -ne 14) { throw ('Plan NATURAL RESIDUAL QA inattendu: '+$nrPlan.Count+'/14') }
        $upgradePlans += $nrPlan
    }
    if($Source.SourceTextMode -ne 'ENGLISH' -and $Source.SourceTextMode -ne 'V0.8.58.4.12_FR' -and $Source.SourceTextMode -ne 'V0.8.58.4.13_FR' -and $Source.SourceTextMode -ne 'V0.9.0_FR') {
        throw 'Source non compatible avec V0.9.0 TEST CANDIDATE 2.'
    }
    foreach($u in $upgradePlans) {
        $uKey=([string]$u.chunk)+'|'+([string]$u.assetRecord)+'|'+([string]$u.slot)+'|'+([string]$u.idHex).ToLowerInvariant()
        if($upgradeOldByKey.ContainsKey($uKey)) { throw ('Correction dupliquee dans les plans: '+$uKey) }
        $upgradeOldByKey[$uKey]=[string]$u.oldTextFR
    }

    # Convert numeric fields and build target index by record.
    $targetsByRecord=@{}
    $changedChunks=New-Object Collections.Generic.HashSet[int]
    foreach($r in $targets) {
        $r | Add-Member -NotePropertyName chunkInt -NotePropertyValue ([int]$r.chunk)
        $r | Add-Member -NotePropertyName recordInt -NotePropertyValue ([int]$r.assetRecord)
        $r | Add-Member -NotePropertyName slotInt -NotePropertyValue ([int]$r.slot)
        $r | Add-Member -NotePropertyName found -NotePropertyValue $false
        if($Source.SourceTextMode -eq 'V0.8.57.7_FR' -or $Source.SourceTextMode -eq 'V0.8.57.8_FR' -or $Source.SourceTextMode -eq 'V0.8.57.9_FR' -or $Source.SourceTextMode -eq 'V0.8.58.0_FR' -or $Source.SourceTextMode -eq 'V0.8.58.3_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.1_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.2_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.5_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.6_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.7_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.8_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.8.1_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.9_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.10_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.11_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.12_FR' -or $Source.SourceTextMode -eq 'V0.8.58.4.13_FR' -or $Source.SourceTextMode -eq 'V0.9.0_FR') {
            $sourceKey=([string]$r.chunk)+'|'+([string]$r.assetRecord)+'|'+([string]$r.slot)+'|'+([string]$r.idHex).ToLowerInvariant()
            if($upgradeOldByKey.ContainsKey($sourceKey)) {
                $sourceText=[string]$upgradeOldByKey[$sourceKey]
            } else {
                $sourceText=[string]$r.textFR
            }
        } else {
            $sourceText=[string]$r.textEN
        }
        $r | Add-Member -NotePropertyName sourceText -NotePropertyValue $sourceText
        if(-not $targetsByRecord.ContainsKey([int]$r.recordInt)) {
            $targetsByRecord[[int]$r.recordInt]=@()
        }
        $targetsByRecord[[int]$r.recordInt] = @($targetsByRecord[[int]$r.recordInt]) + @($r)
        [void]$changedChunks.Add([int]$r.chunkInt)
    }

    # Load raw validated font replacement records.
    $fontByRecord=@{}
    foreach($f in Get-ChildItem -LiteralPath $FontDir -Filter 'record_*.bin' -File) {
        if($f.BaseName -match '^record_(\d{3})$') {
            $rec=[int]$Matches[1]
            $fontByRecord[$rec]=$f.FullName
        }
    }
    if($fontByRecord.Count -ne 20) { throw ('Assets fonte attendus: 20, trouves: '+$fontByRecord.Count) }

    Log '[1/8] Decodage du manifest source...'
    $decodedManifest=Join-Path $Work 'manifest.original.dec'
    Expand-Manifest $Clean.Manifest $decodedManifest $Zstd
    $man=Parse-Manifest $decodedManifest (Get-Item $Clean.Package).Length
    $valid=@($man.rows | Where-Object {$_.valid})
    if($valid.Count -ne 154) { throw ('Manifest original: '+$valid.Count+'/154 chunks valides.') }
    $mb=[byte[]]::new($man.bytes.Length)
    [Buffer]::BlockCopy($man.bytes,0,$mb,0,$man.bytes.Length)

    # Resolve font record -> chunk from Section A.
    foreach($rec in $fontByRecord.Keys) {
        $p=[int]$man.secAStart+$rec*32
        $chunk=[int](Get-U32 $mb ($p+16))
        [void]$changedChunks.Add($chunk)
    }

    $changedChunkDec=@{}
    $changedChunkSize=@{}
    $assetAudit=New-Object Collections.Generic.List[string]
    $assetAudit.Add('chunk;record;oldOffset;oldSize;newOffset;newSize;kind;targetCount')

    Log ('[2/8] Reconstruction de '+$changedChunks.Count+' chunks modifies...')
    foreach($chunk in @($changedChunks | Sort-Object)) {
        $row=@($valid | Where-Object {$_.index -eq $chunk}) | Select-Object -First 1
        if(-not $row) { throw ('Chunk '+$chunk+' introuvable dans le manifest.') }

        Log ('      chunk '+$chunk+' - extraction...')
        $dec=Extract-Chunk $Clean.Package $row $Zstd $Work $chunk
        Log ('      chunk '+$chunk+' - lecture decompressee...')
        $before=[IO.File]::ReadAllBytes($dec)
        Log ('      chunk '+$chunk+' - validation Section A...')
        $assets=@(Validate-ChunkPartition $mb $man $chunk $before.Length)
        Log ('      chunk '+$chunk+' - '+$assets.Count+' assets Section A')

        $out=[IO.MemoryStream]::new()
        try {
            foreach($a in ($assets | Sort-Object offset)) {
                $raw=Slice-Bytes $before ([int]$a.offset) ([int]$a.size)
                $newRaw=$raw
                $kind='UNCHANGED'
                $targetCount=0

                if($fontByRecord.ContainsKey([int]$a.record)) {
                    $newRaw=[IO.File]::ReadAllBytes([string]$fontByRecord[[int]$a.record])
                    $kind='FONT_V0.8.57.9_GLYPH_FIX'
                }
                elseif($targetsByRecord.ContainsKey([int]$a.record)) {
                    [object[]]$trs = $targetsByRecord[[int]$a.record]
                    foreach($tr in $trs) {
                        if([int]$tr.chunkInt -ne $chunk) {
                            throw ('Corpus incoherent: record '+$a.record+' annonce chunk '+$tr.chunkInt+' mais manifest='+$chunk)
                        }
                    }
                    $newRaw=Rebuild-StringAsset $raw $trs ([int]$a.record)
                    $kind='STRING_TABLE_FR'
                    $targetCount=$trs.Count
                }

                $newOffset=[long]$out.Position
                $out.Write($newRaw,0,$newRaw.Length)

                # Update Section A record offset/size in decoded manifest.
                Set-U32 $mb ([int]$a.pos+20) ([uint32]$newOffset)
                Set-U32 $mb ([int]$a.pos+24) ([uint32]$newRaw.Length)

                $assetAudit.Add(('{0};{1};{2};{3};{4};{5};{6};{7}' -f
                    $chunk,$a.record,$a.offset,$a.size,$newOffset,$newRaw.Length,$kind,$targetCount))
            }
            $after=$out.ToArray()
        } finally {$out.Dispose()}

        $outDec=Join-Path $Work ('chunk_'+$chunk+'.new.dec')
        [IO.File]::WriteAllBytes($outDec,$after)
        $changedChunkDec[$chunk]=$outDec
        $changedChunkSize[$chunk]=$after.Length

        # Validate updated partition immediately.
        [void](Validate-ChunkPartition $mb $man $chunk $after.Length)
        Log ('      chunk '+$chunk+' : '+$before.Length+' -> '+$after.Length)
    }

    [IO.File]::WriteAllLines(
        (Join-Path $script:ReportDir 'PACKAGE_ASSET_REBUILD_AUDIT_V0.8.58.4.13.csv'),
        $assetAudit,
        (New-Object Text.UTF8Encoding($true))
    )

    $notFound=@($targets | Where-Object {-not $_.found})
    if($notFound.Count -ne 0) {
        $notFound | Export-Csv -LiteralPath (Join-Path $script:ReportDir 'PACKAGE_TARGETS_NOT_FOUND.csv') -Delimiter ';' -NoTypeInformation -Encoding UTF8
        throw ('Cibles PACKAGE non trouvees: '+$notFound.Count)
    }
    Log ('      Cibles PACKAGE validees: '+$targets.Count+'/32307')
    Log ('      Assets fonte injectes: '+$fontByRecord.Count+'/20')

    Log '[3/8] Recompression des chunks modifies...'
    $changedZst=@{}
    foreach($chunk in @($changedChunks | Sort-Object)) {
        $znew=Join-Path $Work ('chunk_'+$chunk+'.new.zst')
        & $Zstd -q -19 -f $changedChunkDec[$chunk] -o $znew
        if($LASTEXITCODE -ne 0) { throw ('Recompression chunk '+$chunk+' impossible.') }
        $changedZst[$chunk]=$znew
    }

    Log '[4/8] Reconstruction du package complet...'
    $newPkg=Join-Path $Work 'ff715342fa4b2d8f_0.V085842'
    $fo=[IO.File]::Open($newPkg,[IO.FileMode]::Create,[IO.FileAccess]::Write)
    $src=[IO.File]::Open($Clean.Package,[IO.FileMode]::Open,[IO.FileAccess]::Read,[IO.FileShare]::Read)
    $newOff=@{}; $newSize=@{}; $running=[long]0
    try {
        foreach($x in ($valid | Sort-Object index)) {
            $i=[int]$x.index
            $newOff[$i]=$running
            if($changedZst.ContainsKey($i)) {
                $bb=[IO.File]::ReadAllBytes($changedZst[$i])
                $fo.Write($bb,0,$bb.Length)
                $newSize[$i]=$bb.Length
                $running+=$bb.Length
            } else {
                [void]$src.Seek([long]$x.offset,[IO.SeekOrigin]::Begin)
                $remain=[int]$x.csize
                $buf=[byte[]]::new(1048576)
                $written=0
                while($remain -gt 0) {
                    $want=[Math]::Min($remain,$buf.Length)
                    $n=$src.Read($buf,0,$want)
                    if($n -le 0) { throw ('Lecture chunk '+$i+' incomplete pendant reconstruction package.') }
                    $fo.Write($buf,0,$n)
                    $remain-=$n
                    $written+=$n
                }
                $newSize[$i]=$written
                $running+=$written
            }
        }
    } finally {$src.Dispose();$fo.Dispose()}

    foreach($x in $valid) {
        $i=[int]$x.index
        $p=[int]$man.rowStart+$i*16
        Set-U32 $mb ($p+4) ([uint32]$newOff[$i])
        Set-U32 $mb ($p+8) ([uint32]$newSize[$i])
        if($changedChunkSize.ContainsKey($i)) {
            Set-U32 $mb ($p+12) ([uint32]$changedChunkSize[$i])
        }
    }

    Log '[5/8] Reconstruction du manifest...'
    $newDec=Join-Path $Work 'manifest.after.dec'
    [IO.File]::WriteAllBytes($newDec,$mb)
    $newFrame=Join-Path $Work 'manifest.new.zst'
    & $Zstd -q -19 -f $newDec -o $newFrame
    if($LASTEXITCODE -ne 0) { throw 'Recompression manifest impossible.' }

    $newMan=Join-Path $Work 'ff715342fa4b2d8f.V085842'
    Make-Manifest $Clean.Manifest $mb $newFrame $newMan

    Log '[6/8] Validation forte du build PACKAGE + FONT...'
    $verifyManDec=Join-Path $Work 'manifest.verify.dec'
    Expand-Manifest $newMan $verifyManDec $Zstd
    $vm=Parse-Manifest $verifyManDec (Get-Item $newPkg).Length
    $vv=@($vm.rows | Where-Object {$_.valid})
    if($vv.Count -ne 154) { throw ('Manifest final: '+$vv.Count+'/154 chunks valides.') }

    foreach($chunk in @($changedChunks | Sort-Object)) {
        $vr=@($vv | Where-Object {$_.index -eq $chunk}) | Select-Object -First 1
        if(-not $vr) { throw ('Chunk final absent: '+$chunk) }
        if([int]$vr.usize -ne [int]$changedChunkSize[$chunk]) {
            throw ('usize final incorrect chunk '+$chunk)
        }

        # Re-decompress every changed chunk from rebuilt package.
        $vdec=Extract-Chunk $newPkg $vr $Zstd $Work (1000+$chunk)
        $vb=[IO.File]::ReadAllBytes($vdec)
        if($vb.Length -ne [int]$changedChunkSize[$chunk]) {
            throw ('Taille redecompressee incorrecte chunk '+$chunk)
        }

        # Validate Section A against the real chunk id (Extract-Chunk's temp id does not matter).
        [void](Validate-ChunkPartition $vm.bytes $vm $chunk $vb.Length)

        # Strong target validation per rebuilt asset.
        $assets=@(Get-ChunkAssets $vm.bytes $vm $chunk | Sort-Object offset)
        foreach($a in $assets) {
            if($targetsByRecord.ContainsKey([int]$a.record)) {
                $raw=Slice-Bytes $vb ([int]$a.offset) ([int]$a.size)
                $tt=Read-StringTable $raw
                foreach($tr in [object[]]$targetsByRecord[[int]$a.record]) {
                    $actual=Get-SlotText $raw $tt ([int]$tr.slot)
                    if($actual -ne [string]$tr.textFR) {
                        throw ('Validation finale FR echouee record '+$a.record+' slot '+$tr.slot)
                    }
                }
            }
            if($fontByRecord.ContainsKey([int]$a.record)) {
                $raw=Slice-Bytes $vb ([int]$a.offset) ([int]$a.size)
                $expected=[IO.File]::ReadAllBytes([string]$fontByRecord[[int]$a.record])
                if($raw.Length -ne $expected.Length) {
                    throw ('Validation fonte taille echouee record '+$a.record)
                }
                for($k=0;$k -lt $raw.Length;$k++) {
                    if($raw[$k] -ne $expected[$k]) {
                        throw ('Validation fonte binaire echouee record '+$a.record+' offset '+$k)
                    }
                }
            }
        }
    }
    Log '      154/154 chunks valides.'
    Log '      32307/32307 cibles PACKAGE FR verifiees.'
    Log '      20/20 assets fonte verifies byte par byte.'
    $builtManifestSha=Get-Sha $newMan
    $builtPackageSha=Get-Sha $newPkg
    if($Source.SourceTextMode -eq 'V0.8.58.4.5_FR') {
        # Source V0.8.58.4.5 -> nouvelle cible V0.8.58.4.6 : pas d'idempotence attendue.
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.6_FR') {
        # Source V0.8.58.4.6 -> nouvelle cible V0.8.58.4.8 : pas d'idempotence attendue.
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.7_FR') {
        # Source V0.8.58.4.7 -> nouvelle cible V0.8.58.4.8 : pas d'idempotence attendue.
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.9_FR') {
        # Source V0.8.58.4.9 -> V0.8.58.4.10.
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.10_FR') {
        # Legacy source path retained for previous validation logic.
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.11_FR') {
        # Source V0.8.58.4.11 -> V0.8.58.4.12.
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.12_FR') {
        # Source V0.8.58.4.12 -> V0.8.58.4.13.
    }
    if($Source.SourceTextMode -eq 'V0.8.58.4.13_FR' -or $Source.SourceTextMode -eq 'V0.9.0_FR') {
        if($builtManifestSha -ne (Get-Sha $Source.Manifest) -or $builtPackageSha -ne (Get-Sha $Source.Package)) { throw 'Le rebuild idempotent de la traduction courante ne reproduit pas exactement les fichiers LIVE.' }
    }

    Log '[7/8] Reconstruction ciblee des 233 DLL selectionnees...'
    $scriptBuildRoot=Join-Path $Work 'scripts_fr_selected'
    $scriptBuild=Build-ScriptDlls $scriptSource.Path $scriptPlan $scriptBuildRoot
    Log '      618/618 textes cibles traites.'
    Log '      616 traductions relocalisees; 2 textes deja identiques.'
    Log '      620 references code corrigees dans 233 DLL.'

    if($ValidateOnly) {
        @(
            'Version=V0.9.0',
            'Status=VALIDATED_V0.9.0_NOT_INSTALLED',
            ('Source='+$Source.Mode),
            ('ScriptSource='+$scriptSource.Mode),
            'PackageTargets=32307/32307',
            'FontAssets=20/20',
            'ManifestChunks=154/154',
            'ScriptDLLTargets=618/618',
            'ScriptDLLRelocated=616',
            'ScriptDLLIdentical=2',
            'ScriptDLLCodeReferences=620',
            'ScriptDLLSelectedFilesChanged=233/233',
            'ScriptDLLNonSelectedFilesKeptOriginal=4016/4016',
            'DialogueChoices=349/349',
            'PackageMissingConversationsAndUI=269/269',
            'TechnicalMessagesExcluded=21/21',
            'GlobalDialogueUniqueReviewed=7284/7284',
            'GlobalDialoguePackageOccurrencesUpdated=10073',
            'OptionsCreditOccurrencesUpdated=3',
            'GlobalDialogueDllOccurrencesUpdated=377',
            'GlobalDialogueBaseOverLimit=0',
            'QaRecoveryAboveEnglishChars=32',
            'FinalTestFixOccurrences=38',
            'AieFixOccurrences=3',
            'QaRecoveryPackageOccurrences=1168',
            'QaRecoveryDllOccurrences=74',
            'QaRecoveryTotalOccurrences=1242',
            'GlyphCompatPackageRows=334',
            'GlyphCompatUppercaseAsciiRows=259',
            'GlyphCompatOeRows=75',
            'UnicodeSafePackageRows=108',
            'UnicodeSafePackageCurlyApostrophes=41',
            'UnicodeSafePackageEmDashes=89',
            'UnicodeSafeDllRows=2',
            'QuoteTitleQaPackageRows=373',
            'QuoteSpacingRows=369',
            'RunningTitleLowercaseRows=6',
            'PunctGrammarQaPackageRows=63',
            'FrenchGuillemetSpacingRows=38',
            'RunningTitleLowercaseDirectriceRows=11',
            'SafePunctSpacingRows=10',
            'NaturalFeelingRows=3',
            'CertainGrammarTypoRows=1',
            'PunctGrammarQaDllRows=1',
            'PunctGrammarQaTotalRows=64',
            'FinalObjectiveQaPackageRows=20',
            'FinalObjectiveQaDllRows=0',
            'PunctResidualQaPackageRows=17',
            'PunctResidualQaDllRows=1',
            'PunctResidualQaTotalRows=18',
            'NaturalResidualQaPackageRows=14',
            'NaturalResidualQaModalRows=8',
            'NaturalResidualQaQuestionRows=6',
            'NaturalResidualQaDllRows=0',
            'UnsupportedDiaeresisI=0',
            ('BuiltManifestSHA256='+(Get-Sha $newMan)),
            ('BuiltPackageSHA256='+(Get-Sha $newPkg)),
            'Backup=NOT_NEEDED_VALIDATE_ONLY'
        ) | Set-Content -LiteralPath (Join-Path $script:ReportDir '99_MACHINE_SUMMARY.txt') -Encoding UTF8
        Log ''
        Log 'VALIDATION COMPLETE TERMINEE. AUCUN FICHIER DU JEU N''A ETE MODIFIE.'
        return
    }

    Log '[8/8] Installation V0.9.0 TEST CANDIDATE 2...' 
    $CleanScriptsBase=Ensure-CleanScriptsBase $scriptSource $legacyScriptPlan
    Log ('      Base scripts anglaise: '+$CleanScriptsBase)
    $backup=Backup-Live $Game $Manifest $Package
    Log ('      Sauvegarde LIVE: '+$backup)
    $InstallStarted=$true
    Copy-Item -LiteralPath $newPkg -Destination $Package -Force
    Copy-Item -LiteralPath $newMan -Destination $Manifest -Force
    if((Get-Sha $Package) -ne (Get-Sha $newPkg)) { throw 'Verification SHA package LIVE echouee.' }
    if((Get-Sha $Manifest) -ne (Get-Sha $newMan)) { throw 'Verification SHA manifest LIVE echouee.' }
    Log '      Retrait de la couche SCRIPT_DLL complete V0.8.58.0...'
    Restore-ScriptDlls $CleanScriptsBase $ScriptsLive $legacyScriptPlan
    Log '      4249/4249 DLL revenues a la base anglaise originale.'
    Install-ScriptDlls $scriptBuild.OutputRoot $ScriptsLive $scriptPlan $scriptBuild.ChangedFiles $scriptBuild.ResultHashes
    $liveScriptsTest=Test-FinalScriptTree $ScriptsLive $legacyScriptPlan $scriptPlan $scriptBuild.ResultHashes
    if(-not $liveScriptsTest.Valid) { throw ('Validation finale des DLL LIVE echouee: '+$liveScriptsTest.First) }
    @(
        'Version=V0.9.0',
        ('ManifestSHA256='+(Get-Sha $Manifest)),
        ('PackageSHA256='+(Get-Sha $Package)),
        ('PatchDataSHA256='+(Get-Sha $ScriptPatchDataPath)),
        ('Installed='+(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'))
    ) | Set-Content -LiteralPath (Get-V090StatePath $Game) -Encoding UTF8
    $InstallStarted=$false

    @(
        'Version=V0.9.0',
        'Status=INSTALLED_V0.9.0_TEST_CANDIDATE_2',
        ('Source='+$Source.Mode),
        ('ScriptSource='+$scriptSource.Mode),
        'PackageTargets=32307/32307',
        'FontAssets=20/20',
        'ManifestChunks=154/154',
        'ScriptDLLTargets=618/618',
        'ScriptDLLRelocated=616',
        'ScriptDLLIdentical=2',
        'ScriptDLLCodeReferences=620',
        'ScriptDLLSelectedFilesChanged=233/233',
        'ScriptDLLNonSelectedFilesKeptOriginal=4016/4016',
        'DialogueChoices=349/349',
        'PackageMissingConversationsAndUI=269/269',
        'TechnicalMessagesExcluded=21/21',
            'GlobalDialogueUniqueReviewed=7284/7284',
            'GlobalDialoguePackageOccurrencesUpdated=10073',
            'OptionsCreditOccurrencesUpdated=3',
            'GlobalDialogueDllOccurrencesUpdated=377',
            'GlobalDialogueBaseOverLimit=0',
            'QaRecoveryAboveEnglishChars=32',
            'FinalTestFixOccurrences=38',
            'AieFixOccurrences=3',
            'QaRecoveryPackageOccurrences=1168',
            'QaRecoveryDllOccurrences=74',
            'QaRecoveryTotalOccurrences=1242',
            'GlyphCompatPackageRows=334',
            'GlyphCompatUppercaseAsciiRows=259',
            'GlyphCompatOeRows=75',
            'UnicodeSafePackageRows=108',
            'UnicodeSafePackageCurlyApostrophes=41',
            'UnicodeSafePackageEmDashes=89',
            'UnicodeSafeDllRows=2',
            'QuoteTitleQaPackageRows=373',
            'QuoteSpacingRows=369',
            'RunningTitleLowercaseRows=6',
            'PunctGrammarQaPackageRows=63',
            'FrenchGuillemetSpacingRows=38',
            'RunningTitleLowercaseDirectriceRows=11',
            'SafePunctSpacingRows=10',
            'NaturalFeelingRows=3',
            'CertainGrammarTypoRows=1',
            'PunctGrammarQaDllRows=1',
            'PunctGrammarQaTotalRows=64',
            'FinalObjectiveQaPackageRows=20',
            'FinalObjectiveQaDllRows=0',
            'PunctResidualQaPackageRows=17',
            'PunctResidualQaDllRows=1',
            'PunctResidualQaTotalRows=18',
            'NaturalResidualQaPackageRows=14',
            'NaturalResidualQaModalRows=8',
            'NaturalResidualQaQuestionRows=6',
            'NaturalResidualQaDllRows=0',
            'UnsupportedDiaeresisI=0',
        ('LiveManifestSHA256='+(Get-Sha $Manifest)),
        ('LivePackageSHA256='+(Get-Sha $Package)),
        ('CleanScriptsBase='+$CleanScriptsBase),
        ('Backup='+$backup)
    ) | Set-Content -LiteralPath (Join-Path $script:ReportDir '99_MACHINE_SUMMARY.txt') -Encoding UTF8

    Log ''
    Log 'INSTALLATION V0.9.0 TEST CANDIDATE 2 TERMINEE.'
    Write-Host ''
    Write-Host 'Le package complet, les fontes, les choix et les conversations uniques sont installes.' -ForegroundColor Green
    Write-Host 'Les 4016 DLL non selectionnees restent en anglais original pour eviter la double couche de sous-titres.' -ForegroundColor Cyan
    Write-Host 'Teste maintenant le tutoriel, le rythme des sous-titres, la tablette et le choix Oui.' -ForegroundColor Cyan
}
catch {
    $script:HadError = $true
    $msg=$_.Exception.Message
    $etype=$_.Exception.GetType().FullName
    $stack=$_.ScriptStackTrace
    $pos=''
    try { $pos=$_.InvocationInfo.PositionMessage } catch {}
    Write-Host ''
    Write-Host ('ERREUR: '+$msg) -ForegroundColor Red
    Write-Host ('TYPE  : '+$etype) -ForegroundColor DarkYellow
    if($stack) { Write-Host ('STACK : '+$stack) -ForegroundColor DarkYellow }
    if(Test-Path -LiteralPath $script:ReportDir) {
        @(
            'ERREUR: '+$msg,
            'TYPE: '+$etype,
            'STACK: '+$stack,
            'POSITION: '+$pos
        ) | Add-Content -LiteralPath (Join-Path $script:ReportDir '00_RESUME.txt') -Encoding UTF8
    }

    if($InstallStarted) {
        try {
            $backupManifest=Join-Path $backup 'ff715342fa4b2d8f'
            $backupPackage=Join-Path $backup 'ff715342fa4b2d8f_0'
            if((Test-Path -LiteralPath $backupManifest) -and (Test-Path -LiteralPath $backupPackage)) {
                Copy-Item -LiteralPath $backupPackage -Destination $Package -Force
                Copy-Item -LiteralPath $backupManifest -Destination $Manifest -Force
                Write-Host 'Etat precedent restaure automatiquement depuis la sauvegarde.' -ForegroundColor Yellow
            } else {
                $Source=Resolve-OriginalSource $Game $Manifest $Package
                $Clean=Ensure-CleanBase $Game $Source
                Copy-Item -LiteralPath $Clean.Package -Destination $Package -Force
                Copy-Item -LiteralPath $Clean.Manifest -Destination $Manifest -Force
                Write-Host 'Anglais original restaure automatiquement apres erreur.' -ForegroundColor Yellow
            }
            if($CleanScriptsBase -and (Test-Path -LiteralPath $CleanScriptsBase) -and $legacyScriptPlan) {
                Restore-ScriptDlls $CleanScriptsBase $ScriptsLive $legacyScriptPlan
                Write-Host 'Scripts anglais originaux restaures automatiquement apres erreur.' -ForegroundColor Yellow
            }
        } catch {
            Write-Host 'ATTENTION: restauration automatique impossible. Lance 02_RESTAURER_VERSION_PRECEDENTE.cmd.' -ForegroundColor Red
        }
    }
}
finally {
    try {
        if(Test-Path -LiteralPath $ReportZip) { Remove-Item -LiteralPath $ReportZip -Force }
        if(Test-Path -LiteralPath $script:ReportDir) {
            Compress-Archive -Path (Join-Path $script:ReportDir '*') -DestinationPath $ReportZip -CompressionLevel Optimal -Force
            Remove-Item -LiteralPath $script:ReportDir -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host ''
            Write-Host ('Rapport cree : '+$ReportZip) -ForegroundColor Cyan
        }
    } catch {}
    Remove-Item -LiteralPath $Work -Recurse -Force -ErrorAction SilentlyContinue
}
if($script:HadError) {
    if(-not $ValidateOnly) { Pause-End }
    exit 1
}
if(-not $ValidateOnly) { Pause-End }
