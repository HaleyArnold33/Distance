library(Distance)
library(mrds)

context("Testing simplified data tables")


test_that("Recover structure for tee data",{

  ## first need to take the golf tee data and put it into a flat format
  data(book.tee.data)
  region <- book.tee.data$book.tee.region
  samples <- book.tee.data$book.tee.samples
  obs <- book.tee.data$book.tee.obs
  obs <- obs[order(obs$object),]
  egdata <- book.tee.data$book.tee.dataframe
  # take only observer 1 data
  egdata <- egdata[egdata$observer==1,]

  # merge sample onto region
  flatdat <- merge(region,samples,by="Region.Label")
  # merge obs table onto that
  flatdat <- merge(flatdat,obs,by=c("Sample.Label","Region.Label"),all.x=TRUE)
  # finally merge the distances onto that
  flatdat <- merge(flatdat,egdata,by="object",all.x=TRUE)


  ## check we can recover the 4 data frames
  sepdat <- Distance:::checkdata(flatdat)

  # this should be a factor really, as is elsewhere
  obs$Region.Label <- as.factor(obs$Region.Label)

  expect_equivalent(sepdat$region.table,region)
  expect_equivalent(sepdat$obs.table,obs)
  expect_equivalent(sepdat$sample.table,samples)
  expect_equivalent(sepdat$data,egdata)


})
