#' removeAllAfterDot
#' a convenience function for extracting gene stable IDs from ensembl ID
#' @param x (string) Ensembl ID (e.g., ENMUSG123456.78)
#' @returns (string) with numbers after dot removed (e.g., ENMUSG123456)
#' @export

removeAllAfterDot = function(x){ gsub("(\\.).*","",x) }