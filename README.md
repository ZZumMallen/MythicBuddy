# Things I want to include

affixes an their descriptions
rewards for time/no time

# Events
## CHAT_MSG_SAY
1. text: string  
2. playerName: string  
3. languageName: string  
4. channelName: string  
5. playerName2: string  
6. specialFlags: string  
7. zoneChannelID: number  
8. channelIndex: number  
9. channelBaseName: string  
10. languageID: number  

## MYB methods

MYB:NewOnject
MYB:Register
MYB:UnRegister
MYB:OnEvent


inInstance, instanceType = IsInInstance()
Returns
inInstance
    Boolean - Whether the player is in an instance; nil otherwise.
instanceType
    String - The instance type:

"none" when outside an instance
"pvp" when in a battleground
"arena" when in an arena
"party" when in a 5-man instance
"raid" when in a raid instance
nil when in an unknown kind of instance, eg. in a scenario

Details
This functon returns correct results immediately upon PLAYER_ENTERING_WORLD.


```lua
C_MythicPlus.GetCurrentAffixes() : affixIDs
C_MythicPlus.GetCurrentSeason() : seasonID
C_MythicPlus.GetCurrentSeasonValues() : displaySeasonID, milestoneSeasonID, rewardSeasonID
C_MythicPlus.GetLastWeeklyBestInformation() : challengeMapId, level
C_MythicPlus.GetOwnedKeystoneChallengeMapID() : challengeMapID
C_MythicPlus.GetOwnedKeystoneLevel() : keyStoneLevel
C_MythicPlus.GetOwnedKeystoneMapID() : mapID
C_MythicPlus.GetRewardLevelForDifficultyLevel(difficultyLevel) : weeklyRewardLevel, endOfRunRewardLevel
C_MythicPlus.GetRewardLevelFromKeystoneLevel(keystoneLevel) : rewardLevel
C_MythicPlus.GetRunHistory([includePreviousWeeks, includeIncompleteRuns]) : runs
C_MythicPlus.GetSeasonBestAffixScoreInfoForMap(mapChallengeModeID) : affixScores, bestOverAllScore
C_MythicPlus.GetSeasonBestForMap(mapChallengeModeID) : intimeInfo, overtimeInfo
C_MythicPlus.GetSeasonBestMythicRatingFromThisExpansion() : bestSeasonScore, bestSeason
C_MythicPlus.GetWeeklyBestForMap(mapChallengeModeID) : durationSec, level, completionDate, affixIDs, members, dungeonScore
C_MythicPlus.GetWeeklyChestRewardLevel() : currentWeekBestLevel, weeklyRewardLevel, nextDifficultyWeeklyRewardLevel, nextBestLevel
C_MythicPlus.IsMythicPlusActive() : isMythicPlusActive
C_MythicPlus.IsWeeklyRewardAvailable() : weeklyRewardAvailable
C_MythicPlus.RequestCurrentAffixes()
C_MythicPlus.RequestMapInfo()
C_MythicPlus.RequestRewards()
C_PlayerInfo.GetPlayerMythicPlusRatingSummary(playerToken) : ratingSummary

C_ChallengeMode.CanUseKeystoneInCurrentMap(itemLocation) : canUse
C_ChallengeMode.ClearKeystone()
C_ChallengeMode.CloseKeystoneFrame()
C_ChallengeMode.GetActiveChallengeMapID() : mapChallengeModeID
C_ChallengeMode.GetActiveKeystoneInfo() : activeKeystoneLevel, activeAffixIDs, wasActiveKeystoneCharged
C_ChallengeMode.GetAffixInfo(affixID) : name, description, filedataid
C_ChallengeMode.GetCompletionInfo() : mapChallengeModeID, level, time, onTime, keystoneUpgradeLevels, practiceRun, oldOverallDungeonScore, newOverallDungeonScore, IsMapRecord, IsAffixRecord, PrimaryAffix, isEligibleForScore, members
C_ChallengeMode.GetDeathCount() : numDeaths, timeLost
C_ChallengeMode.GetDungeonScoreRarityColor(dungeonScore) : scoreColor
C_ChallengeMode.GetGuildLeaders() : topAttempt
C_ChallengeMode.GetKeystoneLevelRarityColor(level) : levelScore
C_ChallengeMode.GetMapScoreInfo() : displayScores
C_ChallengeMode.GetMapTable() : mapChallengeModeIDs
C_ChallengeMode.GetMapUIInfo(mapChallengeModeID) : name, id, timeLimit, texture, backgroundTexture
C_ChallengeMode.GetOverallDungeonScore() : overallDungeonScore
C_ChallengeMode.GetPowerLevelDamageHealthMod(powerLevel) : damageMod, healthMod
C_ChallengeMode.GetSlottedKeystoneInfo() : mapChallengeModeID, affixIDs, keystoneLevel
C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor(specificDungeonOverallScore) : specificDungeonOverallScoreColor
C_ChallengeMode.GetSpecificDungeonScoreRarityColor(specificDungeonScore) : specificDungeonScoreColor
C_ChallengeMode.HasSlottedKeystone() : hasSlottedKeystone
C_ChallengeMode.IsChallengeModeActive() : challengeModeActive
C_ChallengeMode.RemoveKeystone() : removalSuccessful
C_ChallengeMode.RequestLeaders(mapChallengeModeID)
C_ChallengeMode.Reset()
C_ChallengeMode.SlotKeystone()
C_ChallengeMode.StartChallengeMode() : success
```