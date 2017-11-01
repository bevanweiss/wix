﻿// Copyright (c) .NET Foundation and contributors. All rights reserved. Licensed under the Microsoft Reciprocal License. See LICENSE.TXT file in the project root for full license information.

namespace WixToolset.Core
{
    using System;
    using System.Collections.Generic;
    using WixToolset.Data;
    using WixToolset.Extensibility;

    public class LibraryContext : ILibraryContext
    {
        public IServiceProvider ServiceProvider { get; }

        public Messaging Messaging { get; set; }

        public bool BindFiles { get; set; }

        public IEnumerable<BindPath> BindPaths { get; set; }

        public IEnumerable<ILibrarianExtension> Extensions { get; set; }

        public string LibraryId { get; set; }

        public IEnumerable<Localization> Localizations { get; set; }

        public IEnumerable<Intermediate> Intermediates { get; set; }

        public IBindVariableResolver WixVariableResolver { get; set; }
    }
}
