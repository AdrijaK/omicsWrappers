makeFeaturesList = function(snakePipesOutputDir){
  #' creates a features list from snakePipes ChIP pipeline
  #' @param snakePipesOutputDir (string) name of snakePipes ChIP pipeline output, for example '$PWD/DNA-mapping/CSAW_MACS2_sampleSheetName'
  #' @returns GRangesList object with list items named as `peaks_all`, `peaks_up`, `peaks_down`
  #' @example
  #'    snakeDir = "/localhome/bric/qlr900/analysis/02_MLL/data/chip-seq/DNA-mapping/CSAW2_MACS2_H3K27ac"
  #'    makeFeaturesList(snakeDir)
  #'    @export

  output =
    GRangesList(
      peaks_all = loadBed6AsGRanges(file.path(snakePipesOutputDir , "DiffBinding_allregions.bed")) ,
      peaks_up = loadFilteredResultsAsGRanges(file.path( snakePipesOutputDir , "Filtered.results.UP.bed")),
      peaks_down = loadFilteredResultsAsGRanges(file.path( snakePipesOutputDir , "Filtered.results.DOWN.bed"))
    )

  return(output)
}
