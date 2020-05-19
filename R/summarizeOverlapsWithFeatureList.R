summarizeOverlapsWithFeatureList = function(GRanges_query, GRangesList_subject) {
  #' counts overlaps between a GRanges object (query) in each item of GRangesList (many subjects)
  #' outputs the count of overlaps for each GRanges element as a data frame
  #' @param GRanges_query GRanges object that will be used as a query
  #' @param GRangesList_subject GRangesList object that will be used as a subject
  #' @returns GRanges_query with overlaps from each item in GRangesList_object as a column in mcols()
  #' @example
  #' TBA
  #' @export

  countOverlapsWithFeature = function(x){
    #' a function that counts overlaps between two GRanges objects
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