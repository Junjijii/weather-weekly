# プロジェクトステータス

## 概要
行橋市の今週の天気予報を表形式で出力するスクリプト（claudecodex協業テスト）

## 現在のバージョン / 状態
開発中

## 協業ステータス
- lead: Claude Code
- executor: Codex
- phase: planning
- handoff_ready: true
- next_owner: Codex
- final_owner: Claude Code
- updated_at: 2026-03-30T12:00:00Z

## 直近の変更（最新を上に追記）
| 日付 | 変更内容 | 担当 |
|------|---------|------|
| 2026-03-30 | 初期セットアップ | Claude Code |

## 次にやること
- [ ] weather.sh を実装（curl + パースで天気データ取得→Markdown表出力）

## 現在の問題
なし

## 引き継ぎメモ
- from: Claude Code
- to: Codex
- branch: main
- commit: 初期コミット
- summary: リポジトリ作成済み。Codexは weather.sh を実装してPRを出す
- tests: `bash weather.sh` で Markdown テーブルが出力されること

## ファイル構成
- `PROJECT_STATUS.md` — プロジェクト状況
- `weather.sh` — （Codexが実装）天気予報をMarkdown表で出力するスクリプト

## テスト方法
`bash weather.sh` を実行し、Markdown形式の表が標準出力に出ること

## デプロイ / リリース方法
N/A（テストプロジェクト）
