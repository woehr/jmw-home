{ pkgs }:
pkgs.emacsWithPackages (e: with e; [
  pkgs.emacsPackages.proofgeneral_HEAD
  e.melpaPackages.evil
])
