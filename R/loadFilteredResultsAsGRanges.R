loadFilteredResultsAsGRanges = function(pathToFile){
  #' loads snakePipes Filtered.results.*.bed file as GRanges object, giving appropriate column names
  #' @param pathToFile (string) an absolute or relative path to a file
  #' @export

  columnNames =
    c("chr", "start", "end", "width", "strand", "score", "nWindows", "logFC.up", "logFC.down", "PValue", "FDR", "direction", "best.logFC" , "best.start", "name")

  output =
    data.table::fread(pathToFile, col.names = columnNames) %>%
    as("GRanges")

  return(output)

}
