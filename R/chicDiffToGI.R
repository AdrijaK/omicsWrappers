#' chicDiffToGI
#' converts ChicDiff resultsMatrix to a GInteractions object
#' @param ChicDiffResultsDataFrame ChicDiff results data frame
#' @returns GInteractions object with baitchr, baitstart, baitend forming anchorOne and OEchr, OEstart, OEend forming anchorTwo. The remaining columns are stored in mcols(). 
#' @export

chicDiffToGI = function(ChicDiffResultsDataFrame){
  
  makeAnchorOneFromDataFrame = function(df) {
    GenomicRanges::makeGRangesFromDataFrame(df, seqnames.field = "baitchr", start.field = "baitstart", end.field = "baitend")
  }
  
  makeAnchorTwoFromDataFrame = function(df) {
    GenomicRanges::makeGRangesFromDataFrame(df, seqnames.field = "OEchr", start.field = "OEstart", end.field = "OEend")
  }
  
  makeMcolsFromDataFrame = function(df){
    df %>% dplyr::select(group, baseMean, log2FoldChange, baitID, maxOE, minOE, regionID, avgLogDist, avWeights, weighted_pvalue, weighted_padj)}
  
  output = InteractionSet::GInteractions(makeAnchorOneFromDataFrame(ChicDiffResultsDataFrame), makeAnchorTwoFromDataFrame(ChicDiffResultsDataFrame))
  
  mcols(output) =  makeMcolsFromDataFrame(ChicDiffResultsDataFrame)
  
  return(output)
  
}