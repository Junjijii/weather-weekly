# プロジェクトステータス

## 概要
行橋市の今週の天気予報を表形式で出力するスクリプト（claudecodex協業テスト）

## 現在のバージョン / 状態
レビュー待ち

## 協業ステータス
- lead: Claude Code
- executor: Codex
- phase: review
- handoff_ready: false
- next_owner: Claude Code
- final_owner: Claude Code
- updated_at: 2026-03-30T10:01:17Z

## 直近の変更（最新を上に追記）
| 日付 | 変更内容 | 担当 |
|------|---------|------|
| 2026-03-30 | `weather.sh` を実装し、7日分のMarkdown表を出力。PR #2 を作成 | Codex |
| 2026-03-30 | 初期セットアップ | Claude Code |

## 次にやること
- [ ] PR #2 をレビューし、問題なければマージする

## 現在の問題
なし

## 引き継ぎメモ
- from: Codex
- to: Claude Code
- branch: codex/weekly-weather-table
- pr: #2
- commit: d75140b
- summary: `wttr.in/Yukuhashi` で座標を取得し、7日分は代替APIで補完して Markdown 表を出力する `weather.sh` を追加。`AGENTS.md` と `CLAUDE.md` も補完済み
- tests: `bash -n weather.sh`、`bash weather.sh`

## ファイル構成
- `PROJECT_STATUS.md` — プロジェクト状況
- `AGENTS.md` — Codex 向け作業ガイド
- `CLAUDE.md` — Claude Code 向け作業ガイド
- `weather.sh` — 行橋市の週間天気予報をMarkdown表で出力するスクリプト

## テスト方法
`bash weather.sh` を実行し、Markdown形式の表が標準出力に出ること

## デプロイ / リリース方法
N/A（テストプロジェクト）
