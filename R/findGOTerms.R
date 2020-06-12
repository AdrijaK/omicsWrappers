#' findGOTerms
#' Find a list of GO terms based on keywords based on constraints "A AND B"
#' Finds a list of GO terms based on two keywords in the `MouseMine` using `InterMineR` library
#' @param KeywordsVector a character string vector of length 2
#' @examples
#' findGOTerms(c("histone", "H3-K4"))
#' @export

findGOTerms = function(KeywordsVector){
  library(InterMineR)

  # load MouseMine
  im = initInterMine(mine=listMines()["MouseMine"])

  # Get template (collection of pre-defined queries)
  template = getTemplates(im)

  # Get GO-terms related templates
  template[grep("go", template$name, ignore.case=TRUE),]

  # Lookup_GO Returns GO terms that match a specified search string:
  queryLookupGO = getTemplateQuery(im, "Lookup_GO")

  # modify the lookup terms so that the query looks for GO terms that contain "histone" AND "H3-K4" (max 2 terms for the default)
  queryLookupGO$where[[1]][["value"]] = KeywordsVector[1]
  queryLookupGO$where[[2]][["value"]] = KeywordsVector[2]

  # run the query. Query returns a `data.frame` object with GO terms that match the query terms
  output = runQuery(im, queryLookupGO)

  return(output)
}
