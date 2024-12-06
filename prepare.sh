#!/bin/sh

./reset.sh

cd osu
./UseLocalFramework.sh
./UseLocalResources.sh
cd ..

fd '(iOS|Android|SampleGame.*|^.*Templates.*|TemplateGame.*|FlappyDon.*|^.*Benchmarks|^.*SourceGeneration.*).csproj' | xargs rm

