#' load snakePipes DiffBinding_allregions.bed BED6 file as GRanges object, giving appropriate column names
#'
#' @param pathToFile (string) an absolute or relative path to a bed file
#' @export

# library(data.table)
# library(GRanges)

loadBed6AsGRanges = function(pathToFile){

  columnNames =
    c("chr", "start", "end", "name", "score", "strand")

  output =
    data.table::fread(pathToFile, col.names = columnNames) %>%
    as("GRanges")

  return(output)

}
