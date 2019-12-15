LNewMap -f Doctor empty.wmap
LGPrep -T 1 -a 200000 -d doctor.0 -n 4 -s "Doctor Patient" empty.wmap train.txt 
LGCopy -T 1 -d doctor.1 doctor.0/wmap doctor.0/gram.0
LGPrep -T 1 -d lm_word -n 4 -s "Test" doctor.0/wmap words.wlist
LFoF -T 1 -n 4 -f 32 lm_word/wmap lm_word/word.fof doctor.1/data.0
LBuild -T 1 -f TEXT -c 2 1 -c 3 1 -x -n 3 lm_word/wmap lm_word/lm_doctor_c doctor.1/data.0 
LPlex -c 2 1 -c 3 1 -T 1 -n 3 -t lm_word/lm_doctor_c test.txt > result_tg_c1.txt
LPlex -c 2 2 -c 3 2 -T 1 -n 3 -t lm_word/lm_doctor_c test.txt > result_tg_c2.txt
LPlex -c 2 3 -c 3 3 -T 1 -n 3 -t lm_word/lm_doctor_c test.txt > result_tg_c3.txt
LPlex -c 2 1 -c 3 1 -T 1 -n 2 -t lm_word/lm_doctor_c test.txt > result_bg_c1.txt
LPlex -c 2 2 -c 3 2 -T 1 -n 2 -t lm_word/lm_doctor_c test.txt > result_bg_c2.txt
LPlex -c 2 3 -c 3 3 -T 1 -n 2 -t lm_word/lm_doctor_c test.txt > result_bg_c3.txt