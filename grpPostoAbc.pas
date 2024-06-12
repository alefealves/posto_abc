<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
    <PropertyGroup>
        <ProjectGuid>{E9083102-F0DF-4B1A-AEF2-88304E0F8B1B}</ProjectGuid>
    </PropertyGroup>
    <ItemGroup>
        <Projects Include="PostoAbc.dproj">
            <Dependencies/>
        </Projects>
        <Projects Include="test\PostoAbcTest.dproj">
            <Dependencies/>
        </Projects>
    </ItemGroup>
    <ProjectExtensions>
        <Borland.Personality>Default.Personality.12</Borland.Personality>
        <Borland.ProjectType/>
        <BorlandProject>
            <Default.Personality/>
        </BorlandProject>
    </ProjectExtensions>
    <Target Name="PostoAbc">
        <MSBuild Projects="PostoAbc.dproj"/>
    </Target>
    <Target Name="PostoAbc:Clean">
        <MSBuild Projects="PostoAbc.dproj" Targets="Clean"/>
    </Target>
    <Target Name="PostoAbc:Make">
        <MSBuild Projects="PostoAbc.dproj" Targets="Make"/>
    </Target>
    <Target Name="PostoAbcTest">
        <MSBuild Projects="test\PostoAbcTest.dproj"/>
    </Target>
    <Target Name="PostoAbcTest:Clean">
        <MSBuild Projects="test\PostoAbcTest.dproj" Targets="Clean"/>
    </Target>
    <Target Name="PostoAbcTest:Make">
        <MSBuild Projects="test\PostoAbcTest.dproj" Targets="Make"/>
    </Target>
    <Target Name="Build">
        <CallTarget Targets="PostoAbc;PostoAbcTest"/>
    </Target>
    <Target Name="Clean">
        <CallTarget Targets="PostoAbc:Clean;PostoAbcTest:Clean"/>
    </Target>
    <Target Name="Make">
        <CallTarget Targets="PostoAbc:Make;PostoAbcTest:Make"/>
    </Target>
    <Import Project="$(BDS)\Bin\CodeGear.Group.Targets" Condition="Exists('$(BDS)\Bin\CodeGear.Group.Targets')"/>
</Project>
