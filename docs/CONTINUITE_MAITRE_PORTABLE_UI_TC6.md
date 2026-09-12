# Continuité maître — Portable UI TC6

## Référence fonctionnelle précédente

`LoneEcho2_FR_Setup_V0.9.0_TC2_VALIDATED.exe`

Le TC2 a été validé par l'utilisateur en installation et fonctionnement réels.

## Nouveau candidat

`LoneEcho2_FR_Traduction_FR_V0.9.0_PORTABLE_UI_TC6.exe`

Le changement porte sur le stub/interface et le mode de distribution, **pas sur le payload de traduction**.

### Décisions utilisateur verrouillées

- design basé sur `assets/ui_skin_reference.png` ;
- drapeau français discret/high-tech intégré au visuel ;
- aucun bouton d'agrandissement ;
- pas de Aide ni Communauté LoVeMaKeRz ;
- À propos conservé en bas à gauche ;
- seulement deux fonctions principales : Installer la traduction / Désinstaller la traduction ;
- aucun programme/gestionnaire installé dans Windows ;
- aucune fonction Réparer / Mettre à jour ;
- À propos et messages importants dans le même style que l'interface, pas en MessageBox blanche.

## Sécurité

L'installation appelle le moteur TC2 validé sans `-RestoreEnglish`.
La désinstallation appelle le même moteur avec `-RestoreEnglish` puis, seulement si cette restauration réussit, supprime les artefacts de sauvegarde/state liés à la traduction.
En cas d'échec, le moteur conserve son mécanisme de rollback et l'UI tente de sauvegarder le ZIP de rapport.

## Validation effectuée ici

- compilation x64 PE GUI réussie ;
- payload source : 45/45 conformes au manifeste ;
- payload embarqué : 45/45 conformes après génération de l'EXE ;
- aucun import d'API d'écriture/suppression de clé de registre dans le nouveau stub ;
- pas de code de copie vers ProgramData/gestionnaire Windows ;
- contrôles statiques PE et SHA-256 effectués.

## Validation restant obligatoirement à faire sous Windows 10/11

Le binaire ne peut pas être exécuté réellement dans l'environnement Linux de génération. Tester :

1. ouverture + UAC ;
2. affichage et mise à l'échelle de l'interface ;
3. détection automatique du dossier ;
4. Parcourir ;
5. À propos ;
6. installation réelle sur base anglaise ;
7. relance : état traduction détectée ;
8. désinstallation réelle et retour anglais ;
9. relance : état non installé ;
10. absence d'entrée dans Applications installées et de copie ProgramData créée par TC6.
