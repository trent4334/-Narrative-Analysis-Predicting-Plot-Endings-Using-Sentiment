# Sentiment-Flow-and-Story-Structure-Analysis-with-R

# Sentiment Flow and Story Structure Analysis with R

This project explores the structure and emotional arc of stories using natural language processing (NLP). By analyzing the placement and sentiment of words across story progressions, the goal is to identify whether a story ends on a “happy note” and uncover words that significantly shape narrative flow.

> 📌 Originally developed as part of an NLP module in a university data science course. Adapted for portfolio presentation.

---

## 📘 Project Description

Using a collection of short stories, this project:
- Tokenizes story text into individual words
- Tracks the **position** of each word within a story (normalized)
- Applies **sentiment scores** by story decile
- Identifies “interesting” words with extreme median positions
- Transforms data for supervised learning to predict **happy endings**

---

## ✨ Key Features

- **Word Position Analysis:** Normalize each word's position from beginning to end of a story
- **Sentiment Decile Mapping:** Compute average sentiment by story segment
- **Word Frequency Filters:** Identify top words used early or late
- **Feature Engineering:** Prepare data for modeling with imputed sentiment trends
- **Binary Outcome Labeling:** Classify whether stories have a happy ending based on final decile sentiment

---

## 🧪 Functions

| Function Name | Description |
|---------------|-------------|
| `make_plot_words()` | Processes raw story text into tokens with relative word positions |
| `make_interesting_words()` | Identifies words most used at the start or end of stories |
| `make_word_decile_counts()` | Counts word frequency by decile |
| `make_sentiments()` | Merges sentiment lexicon and calculates average sentiment by decile |
| `process_plots_for_modeling()` | Transforms decile sentiment into features and binary labels |

---

## 📈 Sample Output

- Top early words: `dawn`, `once`, `mysterious`
- Top late words: `freedom`, `wedding`, `smile`
- Model-ready data includes 9 sentiment deciles + binary `is_happy_ending` variable

---

## 🧰 Tools Used

- **R** (with tidyverse, `tidytext`, `dplyr`, `testthat`)
- Sentiment lexicon (e.g., NRC or Bing)
- Text tokenization and aggregation
- Functional programming and tidy data design

---

## 📂 Project Files

- `assignment5.R`: All core functions and helper utilities
- `assignment5_workflow.Rmd`: Full analysis and narrative exploration
- `assignment5_workflow.pdf`: Rendered report with results and plots


---

## ✅ Next Steps

- Apply classification models to the `is_happy_ending` variable
- Compare logistic regression, decision trees, and ensemble models
- Experiment with transformer-based embeddings for improved sentiment modeling
