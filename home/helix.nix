{ pkgs, lib, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_frappe";
      editor = {
        cursorline = true;
        color-modes = true;
      };
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      editor.indent-guides = {
        render = true;
      };
      editor.lsp = {
        display-inlay-hints = true;
      };
      editor.file-picker = {
        hidden = true;
        follow-symlinks = true;
        deduplicate-links = true;
        git-ignore = true;
        parents = true;
        max-depth = 4;
        git-global = true;
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
      {
        name = "markdown";
        soft-wrap.enable = true;
        text-width = 80;
        soft-wrap.wrap-at-text-width = true;
      }
    ];
  };
}
