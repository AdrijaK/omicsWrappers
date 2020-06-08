#' countFeatureSet
#' counts overlaps between `GRangesObject` and three cathegories of peaks from snakePipes results directory specified by `ChipNamesVector`
#' The three cathegories of peaks are: snakePipesDir/DiffBind_all.tsv (peaks_none, which are all peaks minus UP and DOWNregulated peaks), snakePipesDir/DiffBind_UP.FilteredResults.tsv (peaks_up), snakePipesDir/DiffBind_DOWN.FilteredResults.tsv (peaks_down) <- make correct the filenames
#' @param GRangesObject ...
#' @param ChipNamesVector ...
#' @returns a data.frame with nrows of GRangesObject and ncols of 3*length(listOfChIPs) with counts of overlaps
#' @export

countFeatureSet = function(GRangesObject, ChipNamesVector){

  # initialize outout data structure that will contain the regions coordinates
  output = GRangesObject
  mcols(output) = NULL
  print(head(mcols(output)))

  for (feature in listOfChIPs) {

    #print(feature)

    # choose appropriate snakePipes directory depending on whether it is ATACseq or ChIPseq:

    if (feature != "ATAC") {
      path = paste0("/localhome/bric/qlr900/analysis/02_MLL/data/chip-seq/DNA-mapping/CSAW_MACS2_", feature)
    } else { path = "/localhome/bric/qlr900/analysis/02_MLL/data/atac/DNA-mapping/CSAW_MACS2_ATAC"}

    ##################################################################################################
    # assign makeFeaturesList output to a variable named after `feature`:
    # assign (x = MLL_featuresList, value = omicsWrappers::makeFeaturesList(path))
    # will give you a variable `MLL_featuresList` that contains an output from makeFeaturesList(path)
    ##################################################################################################

    featuresListName = paste0(feature, "_featuresList") %>% str_remove("_batch2")

    assign(
      x = featuresListName,
      value = omicsWrappers::makeFeaturesList(path)
    )

    # then summarize the count summary and name the output columns after tehe ChIP/ATAC mark:
    countsummary =
      omicsWrappers::summarizeOverlapsWithFeatureList(GRangesObject, eval(parse(text = featuresListName))) %>%
      as.data.frame %>%
      dplyr::select(contains("peaks")) %>%
      dplyr::rename_all(function(x) paste0(str_remove(feature, "_batch2"),"_" , x))

    mcols(output) = mcols(output) %>% cbind(countsummary)
  }

  return(output)

}
