#' Summarize overlaps with a feature list
#'
#' counts overlaps between a GRanges object (query) in each item of GRangesList (many subjects)
#' outputs the count of overlaps for each GRanges element as a data frame
#' @param GRanges_query GRanges object that will be used as a query
#' @param GRangesList_subject GRangesList object that will be used as a subject
#' @returns GRanges_query with overlaps from each item in GRangesList_object as a column in mcols()
#' @examples
#'
#' # make a features list from snakePipes chip-seq pipeline output
#' featuresList = makeFeaturesList("/scratch/adrija/02_MLL/data/chip-seq/DNA-mapping/CSAW_MACS2_CEBPa")
#'
#' # make a GRanges query from ATAC peaks
#' ATAC_peaks = omicsWrappers::loadBed6AsGRanges("/localhome/bric/qlr900/analysis/02_MLL/data/atac/DNA-mapping/CSAW_MACS2_ATAC/DiffBinding_allregions.bed")
#'
#' summarize overlaps
#' summarizeOverlapsWithFeatureList(ATAC_peaks, featuresList)
#' @export

summarizeOverlapsWithFeatureList = function(GRanges_query, GRangesList_subject) {

  countOverlapsWithFeature = function(x){
    # a function that counts overlaps between two GRanges objects
    countOverlaps(GRanges_query, x)
  }

  tmp =
    DataFrame(lapply(GRangesList_subject, countOverlapsWithFeature))

  output =
    GRanges_query

  mcols(output) =
    mcols(output) %>%
    cbind(tmp)

  return(output)

}
