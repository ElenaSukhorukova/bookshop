import { createApi, fetchBaseQuery } from '@reduxjs/toolkit/query/react';

export const apiSlice = createApi({
    reducerPath: 'api',
    baseQuery: fetchBaseQuery({baseUrl: process.env.BUSINESS_URL}),
    tagTypes: ['User'],
    endpoints: builder => ({
        newUser: builder.query({
            query: () => '/users/new',
            providesTags: ['User']
        }),
    //     createHero: builder.mutation({
    //         query: hero => ({
    //             url: '/heroes',
    //             method: 'POST',
    //             body: hero
    //         }),
    //         invalidatesTags: ['Heroes']
    //     }),
    //     deleteHero: builder.mutation({
    //         query: id => ({
    //             url: `/heroes/${id}`,
    //             method: 'DELETE',
    //             body: id
    //         }),
    //         invalidatesTags: ['Heroes']
    //     })
    })
})

export const {useNewUserMutation} = apiSlice;