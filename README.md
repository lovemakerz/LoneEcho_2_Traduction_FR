# Lone Echo II — Traduction française v1.2.0 — Installateur portable RC1

Installateur Windows x64 autonome de la traduction française complète réalisée par **LoVeMaKeRz**.

## Architecture

La v1.2.0 installe depuis un jeu anglais propre :

1. le corpus complet de la V0.9.0 (42 180 entrées traitées) ;
2. le correctif Calibration `No -> Non` ;
3. les 15 corrections finales ff715 ;
4. READY R4 : `Ready to move on? -> On continue ?` sur les 4 assets actifs ;
5. deux corrections typographiques finales intégrées directement dans le payload SCRIPT_DLL :
   - `Incroyable? -> Incroyable ?`
   - `À la bonne époque? -> À la bonne époque ?`

RATIONS reste volontairement hors périmètre.

## Sécurité / restauration

- aucun programme n'est installé dans Windows ;
- le payload est extrait uniquement dans un dossier temporaire ;
- les sauvegardes originales du moteur V0.9.0 sont conservées pour la restauration ;
- les trois correctifs finaux utilisent leurs sauvegardes validées ;
- désinstallation en ordre inverse : READY -> ff715 -> Calibration -> base complète -> anglais ;
- rollback automatique tenté si une étape d'installation échoue.

## Important pour le test RC1

Si une ancienne traduction est détectée, l'installateur refuse de poser v1.2.0 par-dessus. Utiliser d'abord **Désinstaller la traduction** avec ce même EXE afin de revenir au jeu anglais, puis relancer l'installation v1.2.0.

## Build

```bash
./build_release.sh
```

Sortie : `build/LoneEcho2_FR_Traduction_FR_v1.2.0_RC1.exe`
