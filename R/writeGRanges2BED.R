#' write GRanges object to BED6 format, converting 1-based GRanges coordinates to 0-based BED6 coordinates
#' this function is borrowed from Devon Ryan's answer at BioStars: https://www.biostars.org/p/89341/
#' @param gr GRanges object
#' @param fileNameString a character string describing psth to the output BED file name
#' @export

writeGRanges2BED = function(gr, fileNameString){

  df = data.frame(seqnames=seqnames(gr),
                   starts=start(gr)-1,
                   ends=end(gr),
                   names=mcols(gr),
                   scores=c(rep(".", length(gr))),
                   strands=strand(gr))
  
  write.table(df, file=fileNameString, quote=F, sep="\t", row.names=F, col.names=F)
  
  return(df)
  
}