#' plot the overlaps with features in a particular way
#'
#' a wrapper function to plot the overlap counts in a particular way
#' @param long_tibble a 'long' format tibble with columns names `cathegory`(factor), `nonzero_features_count`(numeric), `Status`(factor)
#' @returns ggplot object
#' @export

plotFeatureOverlaps = function(long_tibble){

  library(ggplot2)

  output =
    ggplot(
      long_tibble, aes(x = cathegory, y = nonzero_features_count, fill = Status)) +
    geom_bar(stat='identity', position = 'dodge') +
    scale_fill_manual(values=c("deeppink3","lightgray", "navy")) +
    ggtitle("% of promoters that overlap feature") +
    ylim(0,100) +
    ylab("% of promoters that overlap feature") +
    xlab("features")+
    theme_classic()

  return(output)
}
