// Types
type IConfig = {
  decimals: number;
  airdrop: Record<string, number>;
};

const airdrop = {
    "decimals": "18",
    "airdrop": {
      "0x016C8780e5ccB32E5CAA342a926794cE64d9C364": "10",
      "0x185a4dc360ce69bdccee33b3784b0282f7961aea": "100",
    },
  };

// Config from generator
// const config: IConfig = {
//   decimals: 18,
//   "airdrop": {
//     "0x016C8780e5ccB32E5CAA342a926794cE64d9C364": 10,
//     "0x185a4dc360ce69bdccee33b3784b0282f7961aea": 100,
//   },
// };

function convertJsonToIConfig(json: any): IConfig {
  return {
    decimals: Number(json.decimals),
    airdrop: json.airdrop
  };
}

const config = convertJsonToIConfig(airdrop);

// Export config
export default config;
