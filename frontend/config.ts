// Types
type IConfig = {
  decimals: number;
  airdrop: Record<string, number>;
};

const json = {
  "airdrop": {
    "0x14682b7A6D065263dE202bbd82C04cfda706E4Af": 207.074,
    "0x1f1A8DF1E6892Bc8b88A58c513ca95e12651c3a9": 145.76,
    "0x22559790840949bcA16BD9AFc8f969b1Affdb2B1": 34.179,
    "0x2D3978b43f3BB2519E80AebF04Fd38679B727737": 122.11,
    "0x6EB8bFB55Db6e15B2Bf6C1c01fE370Bf7e127339": 194.092,
    "0x71d903deDCBA66570D351cE4cB39c200e7E5b6c8": 138.615,
    "0x75440e0c6188aE5361a11d6BcFd80c298c142875": 8.082,
    "0x9FFa1ca74425A4504aeb39Fc35AcC0EB3a16A00A": 24.676,
    "0xC61171042dA57705D69237fD53ecbDb15b8D340c": 125.418
  },
  "decimals": 18
}

function convertJsonToIConfig(json: any): IConfig {
  return {
    decimals: Number(json.decimals),
    airdrop: json.airdrop
  };
}

const config = convertJsonToIConfig(json);

// Export config
export default config;