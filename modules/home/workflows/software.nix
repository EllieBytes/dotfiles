{ inputs, ... }: 

{
  home.packages = [ inputs.nvim-config.packages.x86_64-linux.default ];
}
