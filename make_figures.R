library(tidyverse)
library(magrittr)
library(patchwork)

if(not(dir.exists("./figures"))){
  dir.create(path = "./figures/")
}


noreg <- read_csv("./log/noreg.txt", col_names = c("epoch", "train_perp", "val_perp"), col_types = "ddd")
dropout1 <- read_csv("./log/dropout1.txt", col_names = c("epoch", "train_perp", "val_perp"), col_types = "ddd")
dropout4 <- read_csv("./log/dropout4.txt", col_names = c("epoch", "train_perp", "val_perp"), col_types = "ddd")
dropout8 <- read_csv("./log/dropout8.txt", col_names = c("epoch", "train_perp", "val_perp"), col_types = "ddd")
explicitonly <-  read_csv("./log/explicitonly.txt", col_names = c("epoch", "train_perp", "val_perp"), col_types = "ddd")
dropout8_implicit <- read_csv("./log/dropout8_implicit.txt", col_names = c("epoch", "train_perp", "val_perp"), col_types = "ddd")
explicit_implicit <- read_csv("./log/explicit_implicit.txt", col_names = c("epoch", "train_perp", "val_perp"), col_types = "ddd")

noreg %<>% gather("metric", "value", train_perp:val_perp) %>% mutate(model="No Reg")
dropout1 %<>% gather("metric", "value", train_perp:val_perp) %>% mutate(model="Drop1")
dropout4 %<>% gather("metric", "value", train_perp:val_perp) %>% mutate(model="Drop4")
dropout8 %<>% gather("metric", "value", train_perp:val_perp) %>% mutate(model="Drop8")
explicitonly %<>% gather("metric", "value", train_perp:val_perp) %>% mutate(model="Expl")
dropout8_implicit %<>% gather("metric", "value", train_perp:val_perp) %>% mutate(model="Drop8+Imp")
explicit_implicit %<>% gather("metric", "value", train_perp:val_perp) %>% mutate(model="Expl+Imp")


df <- bind_rows(noreg, dropout1, dropout4, dropout8, explicitonly, dropout8_implicit, explicit_implicit) 
df %<>% filter(epoch <= 50) # trained some models for longer.

reg_cols <- c(`No Reg` = "#e5d8bd",
               `Drop1` = "#2ca25f",
               `Drop4` = "#99d8c9",
               `Drop8` = "#fdcdac",
               `Drop8+Imp` = "#b3cde3",
               `Expl` = "#decbe4",
               `Expl+Imp` = "#fbb4ae"
               )
reg_scale <- scale_color_manual(values=reg_cols)

train <- df %>% filter(metric=="train_perp") %>% ggplot(aes(x=epoch, y=value, color=model)) + geom_line(size=2) +
  scale_y_continuous() + labs(title="Training Perplexity", x = "Epoch", y = "Perplexity", color="Regularizer") + coord_cartesian(xlim = c(0, 50), ylim=c(0, 130)) +
  reg_scale + 
  theme_minimal() 

valid <- df %>% filter(metric=="val_perp") %>% ggplot(aes(x=epoch, y=value, color=model)) + geom_line(size=2) +
  scale_y_continuous() + labs(title="Validation Perplexity", x = "Epoch", y = "Perplexity", color="Regularizer") + coord_cartesian(xlim = c(0, 50), ylim=c(0, 130)) +
  reg_scale +
  theme_minimal() + guides(color=FALSE)


collected_plot <- train + valid + plot_layout(guides = 'collect') & theme(legend.position="bottom")
ggsave("./figures/train.png", train, device="png", width = 8, height=6, units="in")
ggsave("./figures/valid.png", valid, device="png", width = 8, height=6, units="in")
ggsave("./figures/collected.png", collected_plot,  device="png", width = 8, height=6, units="in")

