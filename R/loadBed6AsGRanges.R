#' load snakePipes DiffBinding_allregions.bed BED6 file as GRanges object, giving appropriate column names
#' note that BED is a 0-based format, while GRanges is 1-based format
#' This means that the start coordinate should be converted to +1 when converting from BED to GRanges
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
    dplyr::mutate(start = start+1) %>%
    as("GRanges")

  return(output)

}
