# #' List stocks by industry
# #' 
# #' This function is specifically made for the ExtJS based OpenCPU app. 
# #' It converts the 'stocktable' dataframe to a tree structure that can be loaded by the ExtJS tree store.
# #' It uses the 'stocktable' data object that ships with the package.
# #' 
# #' @export
# listbyindustry <- function(){
# 	outlist <- list();
# 	sectors <- split(stocktable, stocktable$Sector);
# 	for(i in seq_along(sectors)){
# 		outlist[[i]] <- list(
# 			text = names(sectors[i]),
# 			children = list()
# 		);
# 		industries <- split(sectors[[i]], sectors[[i]]$Industry);
# 		for(j in seq_along(industries)){
# 			outlist[[i]]$children[[j]] <- list(
# 				text = names(industries[j]),
# 				children = makeleafs(industries[[j]])
# 			);			
# 		}	
# 	}
# 	list(
# 		text = ".",
# 	   	children = outlist
#   	)
# }
# 
# makeleafs <- function(subtable){
#   unname(
#     apply(subtable, 1, function(x){
#       list(
#         id = paste("symbol", x["Ticker"], sep="_"),
#         text = paste(x["Ticker"], x["Company"], sep=" - "),
#         leaf = TRUE
#       )
#     })
#   );
# }
