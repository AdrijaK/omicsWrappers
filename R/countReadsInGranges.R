#' countReadsInGranges counts reads in aligned BAM files for regions stored in GRanges by using Rsubread::Featurecounts.
#' @param feature of ChIPs - the name of ChIP to find the correct files in snakePipes BAM files.
#' @param GRangesObject GRanges object for which featyres should be counted
#' @param snakePipesDirectoryString The full path to a snakePipes directory with filtered BAM files
#' @param nthreads number of threads
#' @returns the output of Rsubread::featureCounts() function (seee ?FeatureCounts 'Value')
#' @example
#' # count reads for bam files that start with "CEBPa" in the file name
#' #gr = head(ATAC_peaks)
#' #snakedir = "/scratch/adrija/02_MLL/data/chip-seq/DNA-mapping/filtered_bam"
#' #countReadsInGranges(gr, snakedir, "CEBPA",36)
#' # count features for all .bam files in the directory
#' #countReadsInGranges(gr, snakedir, "",36)
#' @export

countReadsInGranges =
  function( GRangesObject,  snakePipesDirectoryString,  feature, nthreads){

    # make a file pattern for selecting bam files.
    file.pattern =
      paste0(feature, ".*.bam$")

    # list files that match teh pattern.
    files.list =
      list.files(snakePipesDirectoryString, pattern=file.pattern, full.names=TRUE)

    # convert granges object to a dataframe compatible with FeatureCounts.
    granges.as.dataframe =
      GRangesObject %>%
      as.data.frame %>%
      dplyr::select(GeneID = name, Chr = seqnames, Start =  start, End = end, Strand = strand)

    # count reads in regions using Featurecounts.
    output =
      Rsubread::featureCounts(files = files.list, annot.ext = granges.as.dataframe, nthreads = nthreads)

  return(output)

}
