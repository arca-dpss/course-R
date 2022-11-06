# Preparing some item-like data

nsample <- 200
nitem <- 30
min_item <- 1
max_item <- 5

items <- lapply(1:nitem, function(i) sample(min_item:max_item, nsample, replace = TRUE))
names(items) <- paste0("item", 1:length(items))

dat <- data.frame(
	id = 1:nsample
)

dat <- cbind(dat, items)

dat <- filor::put_random_na(dat, 30, "id")

saveRDS(dat, "exercises/data/item_data.rds")
