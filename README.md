# Nix konfigurasjon for Mac

Dette prosjektet inneholder en Nix konfigurasjon for Mac (og muligens Linux
senere) som setter opp systemet og holder orden på pakker.

Oppsettet er laget med inspirasjon fra [dette
oppsettet](https://github.com/bgub/nix-macos-starter/blob/main/README.md).

## Oppbygning

- [`./darwin`](./darwin) inneholder Mac spesifikk oppsett
- [`./home`](./home) inneholder [Home
Manager](https://nix-community.github.io/home-manager/) oppsett
- [`./hosts`](./hosts) inneholder maskin spesifikt oppsett

## Installasjon

Installer [Lix](https://lix.systems/install/#on-any-other-linuxmacos-system) som
anbefalt av `nix-darwin`:

```bash
curl -sSf -L https://install.lix.systems/lix | sh -s -- install
```

Og kjør deretter følgende for å installere `nix-darwin`:

```bash
sudo nix run nix-darwin/nix-darwin-25.11#darwin-rebuild -- switch --flake .#HOSTNAME
```

Etter at dette er gjort første gang kan man senere kjøre:

```bash
sudo darwin-rebuild switch --flake .#HOSTNAME
```
