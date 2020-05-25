#' findMouseGenesFromGO
#' find mouse genes based on one or many GO terms.
#' This function uses AnnotationDbi library to query org.Mm.eg.db for genes associated with GO term IDs of interest
#'
#' @param GOstringOrVector (string or vector of strings with GO terms of interest)
#'
#' @returns
#' data.frame object containing columns:
#' "GO": queried GO term ID ('GO:0042800')
#' "EVIDENCE": evidence level for ontology term (see http://geneontology.org/docs/guide-go-evidence-codes/)
#' "ONTOLOGY": 'MF' (molecular function), 'BP'(Biological pathway) , 'CC' (cellular component)
#' "ENSEMBL": ENSEMBL gene ID (e.g., 'ENSMUSG00000028053')
#' "SYMBOL": gene symbol (e.g., 'Ash1l')
#' "ENZYME": KEGG enzyme name (e.g., 2.1.1.43)
#' If the GO term doesnt contain any genes, all columns except "GO" contain <NA>s
#'
#' @examples
#' findMouseGenesFromGO("GO:0070734")
#' @export

findMouseGenesFromGO =
  function(GOstringOrVector){

    # requirements
    library(org.Mm.eg.db)
    library(AnnotationDbi)

    columns = c("ENSEMBL","SYMBOL", "ENZYME", "ONTOLOGY")

    output =
      AnnotationDbi::select(org.Mm.eg.db,
                            keys = GOstringOrVector,
                            columns = columns,
                            keytype="GO"

      )

    return(output)

  }
