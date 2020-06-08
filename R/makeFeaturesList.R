#' create a features list from snakePipes ChIP pipeline
#'
#' @param snakePipesOutputDir (string) name of snakePipes ChIP pipeline output, for example '$PWD/DNA-mapping/CSAW_MACS2_sampleSheetName'
#' @returns GRangesList object with list items named as `peaks_none`, `peaks_up`, `peaks_down`
#' @examples
#'    snakeDir = "/localhome/bric/qlr900/analysis/02_MLL/data/chip-seq/DNA-mapping/CSAW2_MACS2_H3K27ac"
#'    makeFeaturesList(snakeDir)
#' @export

makeFeaturesList = function(snakePipesOutputDir){

  output =
    GRangesList(
      peaks_none = loadBed6AsGRanges(file.path(snakePipesOutputDir , "DiffBinding_allregions.bed")) ,
      peaks_up = loadFilteredResultsAsGRanges(file.path( snakePipesOutputDir , "Filtered.results.UP.bed")),
      peaks_down = loadFilteredResultsAsGRanges(file.path( snakePipesOutputDir , "Filtered.results.DOWN.bed"))
    )

  # modify freatures list so that there is a new item "peaks_none" which harbours all chip peaks that are NOT identified as up- or down-regulated
  output$peaks_none$isUp  = countOverlaps(output$peaks_all, output$peaks_up)
  output$peaks_none$isDown = countOverlaps(output$peaks_all, output$peaks_down)
  # keep only "nonregulated" peaks in peaks_none
  output$peaks_none = output$peaks_none[(output$peaks_none$isUp + output$peaks_none$isDown) == 0]

  return(output)
}
