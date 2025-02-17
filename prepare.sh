#!/bin/sh

./reset.sh

cd osu
./UseLocalFramework.sh
./UseLocalResources.sh
cd ..

rm -rf ./osu/Templates
fd '(iOS|Android|SampleGame.*|TemplateGame.*|FlappyDon.*|^.*Benchmarks|^.*SourceGeneration.*).csproj' | xargs rm
git update-index --skip-worktree <>
