#!/bin/bash
seeds=(0 1 2 3 4)
model_family="BLIP2"
checkpoints=("Salesforce/blip2-opt-2.7b")
loading_precision="FP16"
datasets="vqa scienceqa ai2d" # vqa scienceqa ai2d
batch_size=2
sample=100
n_shots=(0 1 3)

multiple_choice_prompt=""
calibration_prompt=" the answer is:"
process_of_elimination_prompt="Select the most suitable option to answer the question. Ignore [MASK] options."

for seed in "${seeds[@]}"; do
    for checkpoint in "${checkpoints[@]}"; do
        for n_shot in "${n_shots[@]}"; do
    
        # multiple choice prompt, using the same script as language modeling
        python vision_language_modeling.py \
            --seed ${seed} \
            --model_family ${model_family} \
            --checkpoint ${checkpoint} \
            --datasets "$datasets" \
            --batch_size  ${batch_size} \
            --loading_precision ${loading_precision} \
            --multiple_choice_prompt "$multiple_choice_prompt" \
            --n_shot ${n_shot} \
            --sample ${sample} \
            # --push_data_to_hub \

        # process of elimination
        python process_of_elimination_vqa.py \
            --seed ${seed} \
            --model_family ${model_family} \
            --checkpoint ${checkpoint} \
            --loading_precision ${loading_precision} \
            --datasets "$datasets" \
            --batch_size  ${batch_size} \
            --multiple_choice_prompt "$multiple_choice_prompt" \
            --process_of_elimination_prompt "${process_of_elimination_prompt}" \
            --scoring_method_for_process_of_elimination "multiple_choice_prompt" \
            --mask_strategy_for_process_of_elimination "lowest" \
            --n_shot ${n_shot} \
            --sample ${sample} \
            # --push_data_to_hub
        done
    done
done