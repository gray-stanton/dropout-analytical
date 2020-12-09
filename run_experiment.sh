EMSIZE=400
NHID=1150
NLAYERS=3
LR=30
CLIP=0.25
EPOCHS=51
BATCHSIZE=20
BPTT=70
WDECAY=1.2e-6

cd ./lstm-qrnn

# No regularization ~ 1hr
#python train_lstm.py --data /home/gray/classwork/740/dropout-analytical/data/tolstoy/ --emsize $EMSIZE --nhid $NHID --nlayers $NLAYERS --lr $LR --clip $CLIP --epochs $EPOCHS  --batch_size $BATCHSIZE --bptt $BPTT --wdecay $WDECAY --update_type no_reg --save /home/gray/classwork/740/dropout-analytical/save/noreg/ --logdir /home/gray/classwork/740/dropout-analytical/log/ --logprefix "noreg"

# Standard Dropout_1 ~ 1hr
python train_lstm.py --data /home/gray/classwork/740/dropout-analytical/data/tolstoy/ --emsize $EMSIZE --nhid $NHID --nlayers $NLAYERS --lr $LR --clip $CLIP --epochs $EPOCHS  --batch_size $BATCHSIZE --bptt $BPTT  --wdecay $WDECAY --update_type drop_standard --dropout_reps 1 --save /home/gray/classwork/740/dropout-analytical/save/dropout1/ --logdir /home/gray/classwork/740/dropout-analytical/log/ --logprefix "dropout1"

# Standard Dropout_4 ~ 2.5 hr
python train_lstm.py --data /home/gray/classwork/740/dropout-analytical/data/tolstoy/ --emsize $EMSIZE --nhid $NHID --nlayers $NLAYERS --lr $LR --clip $CLIP --epochs $EPOCHS  --batch_size $BATCHSIZE --bptt $BPTT --wdecay $WDECAY --update_type drop_standard --dropout_reps 4 --save /home/gray/classwork/740/dropout-analytical/save/dropout4/ --logdir /home/gray/classwork/740/dropout-analytical/log/ --logprefix "dropout4"

# Standard Dropout_8
python train_lstm.py --data /home/gray/classwork/740/dropout-analytical/data/tolstoy/ --emsize $EMSIZE --nhid $NHID --nlayers $NLAYERS --lr $LR --clip $CLIP --epochs $EPOCHS  --batch_size $BATCHSIZE --bptt $BPTT --wdecay $WDECAY --update_type drop_standard --dropout_reps 8 --save /home/gray/classwork/740/dropout-analytical/save/dropout8/ --logdir /home/gray/classwork/740/dropout-analytical/log/ --logprefix "dropout8"

# regularization strength taken from D.1

# Explicit Regularizer only
python train_lstm.py --data /home/gray/classwork/740/dropout-analytical/data/tolstoy/ --emsize $EMSIZE --nhid $NHID --nlayers $NLAYERS --lr $LR --clip $CLIP --epochs $EPOCHS  --batch_size $BATCHSIZE --bptt $BPTT --wdecay $WDECAY --update_type jreg_sample_logit --exp_regi 0.66 --exp_regh 0.66 --exp_regw 0.66 --exp_rego 0.66   --save /home/gray/classwork/740/dropout-analytical/save/explicitonly/ --logdir /home/gray/classwork/740/dropout-analytical/log/ --logprefix "explicitonly"

# Drop8 + Implicit Regularizer only
python train_lstm.py --data /home/gray/classwork/740/dropout-analytical/data/tolstoy/ --emsize $EMSIZE --nhid $NHID --nlayers $NLAYERS --lr $LR --clip $CLIP --epochs $EPOCHS  --batch_size $BATCHSIZE --bptt $BPTT --wdecay $WDECAY --save /home/gray/classwork/740/dropout-analytical/save/dropout8_implicit/ --update_type drop_standard+taylor_fo --imp_regi 0.77 --imp_rego 0.77 --imp_regh 0.77  --imp_regw 0.77 --dropout_reps 8 --logdir /home/gray/classwork/740/dropout-analytical/log/ --logprefix "dropout8_implicit"

# Explicit + Implicit Reg ~ 5hr
python train_lstm.py --data /home/gray/classwork/740/dropout-analytical/data/tolstoy/ --emsize $EMSIZE --nhid $NHID --nlayers $NLAYERS --lr $LR --clip $CLIP --epochs $EPOCHS  --batch_size $BATCHSIZE --bptt $BPTT --wdecay $WDECAY --save /home/gray/classwork/740/dropout-analytical/save/explicit_implicit/ --update_type jreg_sample_logit+taylor_fo --exp_regi 0.66 --exp_regh 0.66 --exp_regw 0.66 --exp_rego 0.66 --imp_regi 0.76 --imp_rego 0.76 --imp_regh 0.76 --imp_regw 0.76 --seed 1212 --logdir /home/gray/classwork/740/dropout-analytical/log/ --logprefix "explicit_implicit"
