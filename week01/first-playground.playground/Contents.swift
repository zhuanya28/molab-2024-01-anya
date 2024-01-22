
// Unicode Skin Tone

// EMOJI MODIFIER FITZPATRICK TYPE-1-2, -3, -4, -5, and -6 (U+1F3FB–U+1F3FF)

// U+1F468: Man
// 👨 👨🏻 👨🏼 👨🏽 👨🏾 👨🏿
let ch1 = "👨"
print("ch1 \(ch1) \(Array(ch1.unicodeScalars))")

for uni in "👨👨🏻👨🏼👨🏽👨🏾👨🏿" {
  print("\(uni) \(Array(uni.unicodeScalars))")
}

// U+1F469: Woman
// 👩 👩🏻 👩🏼 👩🏽 👩🏾 👩🏿
let ch2 = "👩"
print("ch2 \(ch2) \(Array(ch2.unicodeScalars))")

for uni in "👩👩🏻👩🏼👩🏽👩🏾👩🏿" {
  print("\(uni) \(Array(uni.unicodeScalars))")
}

// https://en.wikipedia.org/wiki/Emoji#Skin_color
