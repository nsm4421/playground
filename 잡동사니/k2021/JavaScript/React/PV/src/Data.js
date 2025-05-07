let data = [
    {
        'Coverage' : '일반상해사망담보',       // 급부명
        'NumBenefit' : 1,                     // 급부개수
        // 탈퇴
        'Exit' : {
            0 : {                           // 급부번호
                'RiskCode' : '상해사망',      // 탈퇴율코드
                'RiskType' : '',             // 탈퇴율 type
                'NonCov' : 0                 // 부담보 기간
            }
        },
        // 급부지급
        'Benefit' : {
            1 : {
                'RiskCode' : '상해사망',
                'RiskType' : '',
                'PayRate' : 1,                 // 지급률
                'ReduceRate' : 0,            // 감액률
                'ReducePeriod' : 0            // 감액기간
            }
        },
        // 납입면제
        'Grant' : {
            'RiskCode' : '',
            'RiskType' : '',
            'InvalidPeriod' : 3
        }
    },
    {
        'Coverage' : '질병상해담보',       // 급부명
        'NumBenefit' : 1,                     // 급부개수
        // 탈퇴
        'Exit' : {
            0 : {                           // 급부번호
                'RiskCode' : '질병사망',      // 탈퇴율코드
                'RiskType' : '',             // 탈퇴율 type
                'NonCov' :  0                 // 부담보 기간
            }
        },
        // 급부지급
        'Benefit' : {
            1 : {
                'RiskCode' : '상해사망',
                'RiskType' : '',
                'PayRate' : 1,                 // 지급률
                'ReduceRate' : 0,            // 감액률
                'ReducePeriod' : 0            // 감액기간
            }
        },
        // 납입면제
        'Grant' : {
            'RiskCode' : '암발생',
            'RiskType' : '',
            'InvalidPeriod' : 3
        }
    },
    {
        'Coverage' : '암발생',       // 급부명
        'NumBenefit' : 3,                     // 급부개수
        // 탈퇴
        'Exit' : {
            0 : {                           // 급부번호
                'RiskCode' : '상해사망',      // 탈퇴율코드
                'RiskType' : '',             // 탈퇴율 type
                'NonCov' : 3                 // 부담보 기간
            }
        },
        // 급부지급
        'Benefit' : {
            1 : {
                'RiskCode' : '기타피부암, 대장점막내암 외 암',
                'RiskType' : '',
                'PayRate' : 1,                 // 지급률
                'ReduceRate' : 0.5,            // 감액률
                'ReducePeriod' : 2           // 감액기간
            },
            2 : {
                'RiskCode' : '기타피부암',
                'RiskType' : '',
                'PayRate' : 0.2,                 // 지급률
                'ReduceRate' : 0.5,            // 감액률
                'ReducePeriod' : 2            // 감액기간
            },
            3 : {
                'RiskCode' : '대장점막내암',
                'RiskType' : '',
                'PayRate' : 0.2,                 // 지급률
                'ReduceRate' : 0.5,            // 감액률
                'ReducePeriod' : 2            // 감액기간
            }
        },
        // 납입면제
        'Grant' : {
            'RiskCode' : '기타피부암, 대장점막내암 외 암',
            'RiskType' : '',
            'InvalidPeriod' : 3
        }
    }
]


export default data;