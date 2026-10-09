# Nix konfigurasjon

Dette prosjektet inneholder min Nix konfigurasjon for Linux (med håp om at det
enkelt kan tilpasses Mac).

## Oppbygning

- [`flake.nix`](./flake.nix) er utgangspunktet for oppsettet
   - Legg til nye maskiner her
- [`home/default.nix`](./home/default.nix) definerer delte oppgaver for alle
  maskiner
- `hosts/<hostname>.nix` definerer maskin spesifikke oppgaver

## Installasjon

Installer `nix` basert på det som er anbefalt for systemet (f.eks. `sudo dnf
install nix` på Fedora).

For førstegangs installasjon:

```bash
nix run github:nix-community/home-manager -- switch --flake .#jorgen@<hostname>
```

Deretter kan man bruke:

```bash
home-manager switch --flake .#jorgen@<hostname>
# NOTE: Oppsettet legger til et alias som også kan brukes
hm-switch
```

### Oppdatere pakker

For å oppdatere pakker låst i `flake.lock` bruk:

```bash
# Oppdaterer pakker i `flake.lock`
nix flake update
# Oppdater `home-manager`
hm-switch
```
