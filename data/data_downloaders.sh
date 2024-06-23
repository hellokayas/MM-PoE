proxy_prefix="https://ghproxy.com/"

# anli
mkdir data/anli/
cd data/anli/
wget https://dl.fbaipublicfiles.com/anli/anli_v1.0.zip
unzip anli_v1.0.zip

cp anli_v1.0/R1/dev.jsonl R1_dev.jsonl
cp anli_v1.0/R2/dev.jsonl R2_dev.jsonl
cp anli_v1.0/R3/dev.jsonl R3_dev.jsonl

cp anli_v1.0/R1/train.jsonl R1_train.jsonl
cp anli_v1.0/R2/train.jsonl R2_train.jsonl
cp anli_v1.0/R3/train.jsonl R3_train.jsonl

# big-bench 
mkdir ../big_bench/
cd ../big_bench/

repo_prefix="https://raw.githubusercontent.com/google/BIG-bench/main/bigbench/benchmark_tasks/"

single_tasks=("disambiguation_qa" "code_line_description" "reasoning_about_colored_objects" "crass_ai" "evaluating_information_essentiality" "identify_math_theorems" "identify_odd_metaphor" "logical_args" "riddle_sense")
conceptual_combinations_subtasks=("contradictions" "emergent_properties" "fanciful_fictional_combinations" "homonyms" "invented_words" "surprising_uncommon_combinations")
strange_stories_subtasks=("boolean" "multiple_choice")
symbol_interpretation_subtasks=("adversarial" "emoji_agnostic" "name_agnostic" "plain" "tricky")
logical_deduction_subtasks=("three_objects" "five_objects" "seven_objects")

for task in "${single_tasks[@]}"
do
    wget -O "${task}.json" "${proxy_prefix}${repo_prefix}${task}/task.json"
done

for subtask in "${conceptual_combinations_subtasks[@]}"
do
    wget -O "conceptual_combinations_${subtask}.json" "${proxy_prefix}${repo_prefix}conceptual_combinations/${subtask}/task.json"
done

for subtask in "${strange_stories_subtasks[@]}"
do
    wget -O "strange_stories_${subtask}.json" "${proxy_prefix}${repo_prefix}strange_stories/${subtask}/task.json"
    
done

for subtask in "${symbol_interpretation_subtasks[@]}"
do
    wget -O "symbol_interpretation_${subtask}.json" "${proxy_prefix}${repo_prefix}symbol_interpretation/${subtask}/task.json"
done

for subtask in "${logical_deduction_subtasks[@]}"
do
    wget -O "logical_deduction_${subtask}.json" "${proxy_prefix}${repo_prefix}logical_deduction/${subtask}/task.json"
done

# cqa
mkdir ../cqa/
cd ../cqa/
wget https://s3.amazonaws.com/commensenseqa/dev_rand_split.jsonl -O dev.jsonl
wget https://s3.amazonaws.com/commensenseqa/test_rand_split_no_answers.jsonl -O test_no_answers.jsonl  
wget https://s3.amazonaws.com/commensenseqa/train_rand_split.jsonl -O train.jsonl

# siqa
mkdir ../siqa/
cd ../siqa/
wget https://storage.googleapis.com/ai2-mosaic/public/socialiqa/socialiqa-train-dev.zip
unzip socialiqa-train-dev.zip
cp socialiqa-train-dev/dev* .
cp socialiqa-train-dev/train* .