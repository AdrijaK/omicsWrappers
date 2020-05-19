plotFeatureOverlaps = function(long_tibble){
  #' a wrapper function to plot the overlap counts in a particular way
  #' @param long_tibble a 'long' format tibble with columns names `cathegory`(factor), `nonzero_features_count`(numeric), `Status`(factor)
  #' @returns ggplot object
  #' @export

  output =
    ggplot(
      long_tibble, aes(x = cathegory, y = nonzero_features_count, fill = Status)) +
    geom_bar(stat='identity', position = 'dodge') +
    scale_fill_manual(values=c("deeppink3","lightgray", "navy")) +
    ggtitle("% of expressed gene promoters (baseMean >10) \noverlapping features") +
    ylim(0,100) +
    ylab("% of genes overlapping the feature at least once") +
    xlab("features")+
    coord_flip() +
    theme_classic()

  return(output)
}
