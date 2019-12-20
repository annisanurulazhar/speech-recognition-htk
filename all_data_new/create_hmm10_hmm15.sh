#printf "WB sp\nWB sil\nTC\n" > mktri.led
#HLEd -A -D -T 1 -n triphones1 -l '*' -i wintri.mlf mktri.led aligned.mlf

#curl https://raw.githubusercontent.com/VoxForge/develop/master/bin/mktrihed.jl > bin/mktrihed.jl
#julia bin/mktrihed.jl monophones1 triphones1 mktri.hed

#mkdir -p hmm10
#HHEd -A -D -T 1 -H hmm9/macros -H hmm9/hmmdefs -M hmm10 mktri.hed monophones1 

#mkdir -p hmm11
#HERest  -A -D -T 1 -C config -I wintri.mlf -t 250.0 150.0 3000.0 -S train.scp -H hmm10/macros -H hmm10/hmmdefs -M hmm11 triphones1

#mkdir -p hmm12
#HERest  -A -D -T 1 -C config -I wintri.mlf -t 250.0 150.0 3000.0 -s stats -S train.scp -H hmm11/macros -H hmm11/hmmdefs -M hmm12 triphones1

printf "AS sp\nMP sil sil sp\nTC" > maketriphones.ded
HDMan -A -D -T 1 -b sp -n fulllist0 -g maketriphones.ded -l flog dict-tri lexicon/lexicon

curl https://raw.githubusercontent.com/VoxForge/develop/master/bin/fixfulllist.jl > bin/fixfulllist.jl
julia bin/fixfulllist.jl fulllist0 monophones0 fulllist

curl https://raw.githubusercontent.com/VoxForge/develop/master/tutorial/tree1.hed > tree.hed
curl https://raw.githubusercontent.com/VoxForge/develop/master/bin/mkclscript.jl > bin/mkclscript.jl
julia bin/mkclscript.jl monophones0 tree.hed

mkdir -p hmm13
HHEd -A -D -T 1 -H hmm12/macros -H hmm12/hmmdefs -M hmm13 tree.hed triphones1

mkdir -p hmm14
HERest -A -D -T 1 -T 1 -C config -I wintri.mlf  -t 250.0 150.0 3000.0 -S train.scp -H hmm13/macros -H hmm13/hmmdefs -M hmm14 tiedlist

mkdir -p hmm15
HERest -A -D -T 1 -T 1 -C config -I wintri.mlf  -t 250.0 150.0 3000.0 -S train.scp -H hmm14/macros -H hmm14/hmmdefs -M hmm15 tiedlist
