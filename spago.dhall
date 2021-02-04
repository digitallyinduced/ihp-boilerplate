{ name = "halogen"
, dependencies = [ "console", "effect", "halogen", "psci-support" ]
, packages = ./packages.dhall
, sources = [ "halogen/**/*.purs" ]
}
