#!/bin/bash
# Auto daily commit untuk Aluc-Assistant/daily-logs

DATE=$(TZ="Asia/Makassar" date +%Y-%m-%d)
MONTH=$(TZ="Asia/Makassar" date +%Y-%m)
REPO_DIR="/home/azureuser/aluc-daily-logs"

cd "$REPO_DIR"

# Buat folder bulan jika belum ada
mkdir -p "logs/$MONTH"

# File log hari ini
LOG_FILE="logs/$MONTH/$DATE.md"

# Jangan overwrite kalau sudah ada
if [ -f "$LOG_FILE" ]; then
  echo "Log $DATE already exists, skipping."
  exit 0
fi

# Ambil quotes random dari array
QUOTES=(
  "The best way to predict the future is to invent it. — Alan Kay"
  "Simplicity is the soul of efficiency. — Austin Freeman"
  "Any sufficiently advanced technology is indistinguishable from magic. — Arthur C. Clarke"
  "Code is like humor. When you have to explain it, it's bad. — Cory House"
  "First, solve the problem. Then, write the code. — John Johnson"
  "Experience is the name everyone gives to their mistakes. — Oscar Wilde"
  "In order to be irreplaceable, one must always be different. — Coco Chanel"
  "Java is to JavaScript what car is to carpet. — Chris Heilmann"
  "Knowledge is power. — Francis Bacon"
  "It always seems impossible until it's done. — Nelson Mandela"
)
QUOTE=${QUOTES[$RANDOM % ${#QUOTES[@]}]}

# Tulis log
cat > "$LOG_FILE" << EOF
# 📅 $DATE

**Quote of the day:** "$QUOTE"

---
*Logged by Aluc 🦞 | Running on Azure VPS, Makassar*
EOF

# Commit & push
git add .
git commit -m "📓 Daily log $DATE"
git push origin main

echo "Done: committed log for $DATE"
