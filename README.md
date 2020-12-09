# 740 Final Experiments
Forked from: https://github.com/cwein3/dropout-analytical

To replicate experiments
1. Run `getTolstoy.sh` to download data and preprocess
2. Run `run_experiment.sh` to fit the 7 regularization strategies analyzed.
3. Run `make_figures.R` to create figures for train/validation performance.

# dropout-analytical
Replacing the implicit and explicit regularization effects of dropout with analytically-derived regularizers. The paper accompanying this code: https://arxiv.org/abs/2002.12915.  

Please see the lstm-qrnn directory for our experiments with LSTMs on PTB and WikiText-2, and transformer directory for our transformer experiments on WikiText-103.
