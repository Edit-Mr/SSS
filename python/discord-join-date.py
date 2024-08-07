import discord
import pandas as pd
import csv
from discord.ext import commands
import os

intents = discord.Intents.default()
intents.members = True
bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'We have logged in as {bot.user}')
    await fetch_users_and_save_csv()

async def fetch_users_and_save_csv():
    guild = bot.get_guild(959823904266944562)  # 伺服器 ID
    members = guild.members
    user_data = []

    for member in members:
        user_data.append({
            "Username": str(member),
            "Join Date": member.joined_at.strftime("%Y-%m-%d %H:%M:%S") if member.joined_at else "Unknown"
        })

    df = pd.DataFrame(user_data)
    df.to_csv('user_data.csv', index=False)
    print("User data has been saved to user_data.csv")
    await bot.close()

# Run the bot with your token
bot.run('')  # Replace with your bot token
