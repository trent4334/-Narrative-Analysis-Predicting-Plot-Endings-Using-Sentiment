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

## 📊 Results

### 🔠 Word Usage Patterns
- Words that appear **early in stories** (low median position):
  - `once`, `dark`, `mysterious`, `began`, `woke`
- Words that appear **late in stories** (high median position):
  - `wedding`, `smile`, `finally`, `free`, `joy`

> These “interesting words” help distinguish how narratives resolve emotionally.

### ❤️ Sentiment Trends by Story Position
- Stories were divided into 10 equal-length segments (deciles).
- Average sentiment score across deciles showed:
  - **Gradual sentiment increase** in happy-ending stories.
  - **Neutral-to-negative sentiment trend** in stories without happy resolution.

### 🧠 Modeling Features (from `process_plots_for_modeling`)
- Sentiment per decile was used as features (`decile_1` through `decile_9`)
- A binary label `is_happy_ending` was generated based on final decile sentiment (≥ 0.5 = happy)

> This creates a labeled dataset ready for classification modeling.

---

## 🧰 Tools Used

- **R** (tidyverse, `tidytext`, `dplyr`, `testthat`)
- Sentiment lexicon (e.g., Bing or NRC)
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
