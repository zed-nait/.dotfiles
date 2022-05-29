if not functions -q fundle
    eval (curl -sfL https://git.io/fundle-install)
end

fundle plugin FabioAntunes/fish-nvm
fundle plugin edc/bass
fundle init
