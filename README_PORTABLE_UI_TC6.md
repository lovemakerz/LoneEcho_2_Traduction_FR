# Lone Echo II — Traduction française V0.9.0 — Portable UI TC6

Utilitaire Windows portable pour installer ou désinstaller uniquement la traduction française de Lone Echo II.

## Principes

- Aucun setup du programme dans Windows.
- Aucune fonction « Réparer » ou « Mettre à jour ».
- Deux actions seulement : **Installer la traduction** et **Désinstaller la traduction**.
- Interface basée exactement sur le PNG 1200×651 fourni par l'auteur.
- Zones interactives alignées sur les pixels du skin ; aucun cadre de bouton supplémentaire n'est dessiné.
- Fenêtres internes de confirmation, progression et À propos cohérentes avec le thème.

## Construction

Lancer `build_release.sh` dans un environnement disposant de clang/lld/objcopy/Python.
Le payload est vérifié avant et après empaquetage.
