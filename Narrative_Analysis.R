make_plot_words <- function(plots, titles) {
  # Initial checks as provided
  if (isFALSE(tibble::is_tibble(plots))) {
    stop("plots should be a tibble")
  }
  
  if (isFALSE(names(plots) == 'text')) {
    stop("plots should have a single variable named text")
  }
  
  if (isFALSE(is.atomic(titles))) {
    stop("titles should be a vector")
  }
  

  plots <- plots %>%
    mutate(
      story_number = cumsum(grepl("<EOS>", text)) + 1   
    )
  
 
  title_tibble <- tibble(
    story_number = 1:length(titles),  
    title = titles
  )
  
  plot_text <- plots %>%
    left_join(title_tibble, by = "story_number") %>%
    select(title, text, story_number)
  
  
  plot_words <- plot_text %>%
    unnest_tokens(word, text)  
  
  plot_words <- plot_words %>%
    group_by(story_number) %>%
    mutate(
      word_position = row_number() / n() 
    ) %>%
    ungroup()
  
  return(plot_words)
}

make_interesting_words <- function(plot_words){
  if(isFALSE(tibble::is_tibble(plot_words))){
    stop("plot_words should be a tibble")
  }
  
  
  word_stats <- plot_words %>%
    group_by(word) %>%
    summarize(
      median_position = median(word_position, na.rm = TRUE),
      word_count = n()
    ) %>%
    ungroup()
  
  frequent_words <- word_stats %>%
    filter(word_count >= 2500)
  
  top_10_high <- frequent_words %>%
    arrange(desc(median_position)) %>%
    slice_head(n = 10)
  
  top_10_low <- frequent_words %>%
    arrange(median_position) %>%
    slice_head(n = 10)
  
  interesting_words <- bind_rows(top_10_high, top_10_low) %>%
    select(word, median_position, word_count)
  
  return(interesting_words)
  
}

make_word_decile_counts <- function(plot_words){
  if(isFALSE(tibble::is_tibble(plot_words))){
    stop("plot_words should be a tibble")
  }
  
  plot_words <- plot_words %>%
    mutate(decile = ceiling(word_position * 10))
  
  word_decile_counts <- plot_words %>%
    group_by(word, decile) %>%
    summarize(n = n(), .groups = 'drop')  
  
  return(word_decile_counts)
}

make_sentiments <- function(plot_words, lexicon){
  if(isFALSE(tibble::is_tibble(plot_words))){
    stop("plot_words should be a tibble")
  }
  
  if(isFALSE(is.data.frame(lexicon))){
    stop("lexicon should be a tibble/data.frame")
  }
   plot_words <- plot_words %>%
    mutate(decile = ntile(word_position, 10))   
  
   lexicon <- lexicon %>%
    group_by(word) %>%
    filter(n_distinct(sentiment) == 1) %>%
    ungroup()
  
   plot_words <- plot_words %>%
    left_join(lexicon, by = "word")
  
   plots <- plot_words %>%
    mutate(sentiment = ifelse(sentiment == "positive", 1, 
                              ifelse(sentiment == "negative", 0, NA))) %>%
    group_by(title, story_number, decile) %>%
    summarize(mean_sentiment = mean(sentiment, na.rm = TRUE)) %>%
    ungroup() %>%
    filter(!is.nan(mean_sentiment))   
  
   return(plots)
}

process_plots_for_modeling <- function(plots){
  if(isFALSE(tibble::is_tibble(plots))){
    stop("plots should be a tibble")
  }
  
  plots_wide <- plots %>%
    pivot_wider(
      names_from = decile,
      values_from = mean_sentiment,
      names_prefix = "decile_"
    )
  
  plots_wide <- plots_wide %>%
    filter(!is.na(decile_10))
  
  plots_wide <- plots_wide %>%
    filter(rowSums(is.na(select(., starts_with("decile_"))[1:9])) < 4)
  
  plots_wide <- plots_wide %>%
    rowwise() %>%
    mutate(across(starts_with("decile_") & -ends_with("10"),
                  ~ ifelse(is.na(.), mean(c_across(starts_with("decile_") & -ends_with("10")), na.rm = TRUE), .))) %>%
    ungroup()
  
  plots_wide <- plots_wide %>%
    mutate(is_happy_ending = ifelse(decile_10 >= 0.5, 1, 0)) %>%
    select(-decile_10)
  
  return(plots_wide)
}

################## Test functions: do not edit the code below ##################
test_make_plot_words <- function(){
  testthat::test_that('Checking that `make_plot_words()` exists', {
    testthat::expect_true(exists('test_make_plot_words'))
  })
  
  testthat::test_that('Checking that make_plot_words() returns a tibble', {
    testthat::expect_true(tibble::is_tibble(plot_words))
  })
  
  testthat::test_that('Checking that column names are correct', {
    testthat::expect_named(plot_words, 
                           expected = c("title","story_number", "word", "word_position"), 
                           ignore.order = TRUE)
  })
  
}

test_make_interesting_words <- function(){
  testthat::test_that('Checking that `make_interesting_words()` exists', {
    testthat::expect_true(exists('make_interesting_words'))
  })
  
  testthat::test_that('Checking that make_interesting_words() returns a tibble', {
    testthat::expect_true(tibble::is_tibble(interesting_words))
  })
  
  testthat::test_that('Checking that column names are correct', {
    testthat::expect_named(interesting_words, 
                           expected = c("word", "median_position", "word_count"), 
                           ignore.order = TRUE)
  })
  
}


test_make_word_decile_counts <- function(){
  testthat::test_that('Checking that `make_word_decile_counts()` exists', {
    testthat::expect_true(exists('make_word_decile_counts'))
  })
  
  testthat::test_that('Checking that make_word_decile_counts() returns a tibble', {
    testthat::expect_true(tibble::is_tibble(word_decile_counts))
  })
  
  testthat::test_that('Checking that column names are correct', {
    testthat::expect_named(word_decile_counts, 
                           expected = c("word", "decile", "n"), 
                           ignore.order = TRUE)
  })
}

test_make_sentiments <- function(){
  testthat::test_that('Checking that `make_sentiments()` exists', {
    testthat::expect_true(exists('make_sentiments'))
  })
  
  testthat::test_that('Checking that make_sentiments() returns a tibble', {
    testthat::expect_true(tibble::is_tibble(plots))
  })
  
  testthat::test_that('Checking that column names are correct', {
    testthat::expect_named(plots, 
                           expected = c("title", "story_number", "decile", "mean_sentiment"), 
                           ignore.order = TRUE)
  })
}

test_process_plots_for_modeling <- function(){
  testthat::test_that('Checking that `process_plots_for_modeling()` exists', {
    testthat::expect_true(exists('process_plots_for_modeling'))
  })
  
  testthat::test_that('Checking that process_plots_for_modeling() returns a tibble', {
    testthat::expect_true(tibble::is_tibble(modeling_data))
  })
  
  testthat::test_that('Checking that column names are correct', {
    testthat::expect_named(modeling_data, 
                           expected = c("story_number", "title", "decile_1", "decile_2", "decile_3", 
                                        "decile_4", "decile_5", "decile_6", 
                                        "decile_7", "decile_8", "decile_9", 
                                        "is_happy_ending"), 
                           ignore.order = TRUE)
  })
}
