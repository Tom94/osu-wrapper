#!/bin/sh

# The first argument is either "osu", "tests", or "framework".
# If "osu", run `dotnet run -p osu/osu.Desktop`
# If "tests", run `dotnet run -p osu/osu.Game.Tests`
# If "framework", run `dotnet run -p osu-framework/osu.Framework.Tests`
# Forward all following args

case "$1" in
	osu)
		shift
		dotnet run --project osu/osu.Desktop "$@"
		;;
	tests)
		shift
		dotnet run --project osu/osu.Game.Tests "$@"
		;;
	framework)
		shift
		dotnet run --project osu-framework/osu.Framework.Tests "$@"
		;;
esac

