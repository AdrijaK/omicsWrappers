#' CandidateInteractionsToGInteractions
#' transform Chicdiff CandidateInteractions (data frame) To GInteractions object using rmap
#' @param chicDiffResultsDataFrame (data.frame) Results matrix from Chicdiff pipeline
#' @param path to rmap file that was used upstream in chicago/chicdiff. Rmap file should have four columns: V1:V4 ("chr", "start", "end", "RF_n")
#' @returns GInteractions object with leftover columns forming mcols
#' @export

CandidateInteractionsToGInteractions = function(candidateInteractionsDataFrame, pathToRmap){
  
  rmap =
    fread(pathToRmap, col.names = c("chr", "start", "end", "RF_n")) %>% as("GRanges")
  
  # transform candidateinteractions into GRanges:
  output = 
    InteractionSet::GInteractions(
      candidateInteractionsDataFrame$baitID, 
      candidateInteractionsDataFrame$oeID, 
      rmap 
    )
  
  mcols(output) = 
    candidateInteractionsDataFrame
  
  return(output)
  
}