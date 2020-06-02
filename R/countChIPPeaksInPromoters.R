#' countChIPPeaksInPromoters
#' count ChIP peaks in promoters of given coordinates.
#' @param pathToSnakePipesDir (string) path to snakePipes Chip output directory (for example CSAW_Gencode_ATAC or CSAW_MACS2_ATAC)
#' @param GRangesObject the genomic ranges (such as expressed gene promoters coordinates) around which to count the ChIP peaks
#' @param titleString the title for title
#' @returns ggplot barplot object with overlap counts where x axis has ChIP peaks class, y axis contains the promoter count and colors depict the gene regulation group.
#' @export

countChIPPeaksInPromoters = function(pathToSnakePipesDir, GRangesObject, titleString){

  output =
    omicsWrappers::makeFeaturesList(pathToSnakePipesDir) %>%
    omicsWrappers::plotOverlapsWithFeaturesList(GRangesObject, .)   +
    xlab("") +
    ggtitle (titleString) +
    theme(axis.text.x = element_text(angle = 45))

  return(output)
}
